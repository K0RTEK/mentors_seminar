import sqlite3
import string
import random
from fastapi import FastAPI, HTTPException, Request, Response
from pydantic import BaseModel

app = FastAPI()


def init_db():
    conn = sqlite3.connect('/app/data/urls.db')
    cursor = conn.cursor()
    cursor.execute('''
                   CREATE TABLE IF NOT EXISTS urls
                   (
                       short_id   TEXT PRIMARY KEY,
                       full_url   TEXT NOT NULL,
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                       clicks     INTEGER   DEFAULT 0
                   )
                   ''')
    conn.commit()
    conn.close()


init_db()


def generate_short_id(length=6):
    chars = string.ascii_letters + string.digits
    return ''.join(random.choice(chars) for _ in range(length))


class UrlCreate(BaseModel):
    url: str


class UrlInfo(BaseModel):
    short_id: str
    full_url: str
    created_at: str
    clicks: int


@app.post("/shorten", response_model=dict)
def shorten_url(url_data: UrlCreate, request: Request):
    short_id = generate_short_id()

    conn = sqlite3.connect('/app/data/urls.db')
    cursor = conn.cursor()
    while True:
        cursor.execute("SELECT 1 FROM urls WHERE short_id = ?", (short_id,))
        if not cursor.fetchone():
            break
        short_id = generate_short_id()

    cursor.execute(
        "INSERT INTO urls (short_id, full_url) VALUES (?, ?)",
        (short_id, url_data.url)
    )
    conn.commit()
    conn.close()

    base_url = f"{request.url.scheme}://{request.url.hostname}"
    if request.url.port:
        base_url += f":{request.url.port}"

    return {"short_url": f"{base_url}/{short_id}"}


@app.get("/{short_id}")
def redirect_to_url(short_id: str, response: Response):
    conn = sqlite3.connect('/app/data/urls.db')
    cursor = conn.cursor()
    cursor.execute("SELECT full_url FROM urls WHERE short_id = ?", (short_id,))
    row = cursor.fetchone()

    if not row:
        conn.close()
        raise HTTPException(status_code=404, detail="URL not found")

    cursor.execute(
        "UPDATE urls SET clicks = clicks + 1 WHERE short_id = ?",
        (short_id,)
    )
    conn.commit()
    conn.close()

    response.status_code = 302
    response.headers["Location"] = row[0]
    return response


@app.get("/stats/{short_id}", response_model=UrlInfo)
def get_url_stats(short_id: str):
    conn = sqlite3.connect('/app/data/urls.db')
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM urls WHERE short_id = ?", (short_id,))
    row = cursor.fetchone()
    conn.close()

    if not row:
        raise HTTPException(status_code=404, detail="URL not found")

    return {
        "short_id": row["short_id"],
        "full_url": row["full_url"],
        "created_at": row["created_at"],
        "clicks": row["clicks"]
    }