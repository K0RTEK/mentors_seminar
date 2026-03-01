import sqlite3
import os
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from typing import Optional

app = FastAPI()

os.makedirs("/app/data", exist_ok=True)

DB_PATH = "/app/data/todo.db"
DB_DIR = os.path.dirname(DB_PATH)


def init_db():
    os.makedirs(DB_DIR, exist_ok=True)

    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()
    cursor.execute('''
                   CREATE TABLE IF NOT EXISTS tasks
                   (
                       id          INTEGER PRIMARY KEY AUTOINCREMENT,
                       title       TEXT NOT NULL,
                       description TEXT,
                       completed   BOOLEAN DEFAULT 0
                   )
                   ''')
    conn.commit()
    conn.close()

init_db()

class TaskCreate(BaseModel):
    title: str
    description: Optional[str] = None
    completed: bool = False

class Task(TaskCreate):
    id: int

@app.post("/items", response_model=Task)
def create_task(task: TaskCreate):
    conn = sqlite3.connect('/app/data/todo.db')
    cursor = conn.cursor()
    cursor.execute(
        "INSERT INTO tasks (title, description, completed) VALUES (?, ?, ?)",
        (task.title, task.description, task.completed)
    )
    task_id = cursor.lastrowid
    conn.commit()
    conn.close()
    return {**task.dict(), "id": task_id}

@app.get("/items", response_model=list[Task])
def get_tasks():
    conn = sqlite3.connect('/app/data/todo.db')
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM tasks")
    tasks = cursor.fetchall()
    conn.close()
    return [dict(task) for task in tasks]

@app.get("/items/{item_id}", response_model=Task)
def get_task(item_id: int):
    conn = sqlite3.connect('/app/data/todo.db')
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM tasks WHERE id = ?", (item_id,))
    task = cursor.fetchone()
    conn.close()
    if not task:
        raise HTTPException(status_code=404, detail="Task not found")
    return dict(task)

@app.put("/items/{item_id}", response_model=Task)
def update_task(item_id: int, task: TaskCreate):
    conn = sqlite3.connect('/app/data/todo.db')
    cursor = conn.cursor()
    cursor.execute(
        "UPDATE tasks SET title = ?, description = ?, completed = ? WHERE id = ?",
        (task.title, task.description, task.completed, item_id)
    )
    if cursor.rowcount == 0:
        conn.close()
        raise HTTPException(status_code=404, detail="Task not found")
    conn.commit()
    conn.close()
    return {**task.dict(), "id": item_id}

@app.delete("/items/{item_id}")
def delete_task(item_id: int):
    conn = sqlite3.connect('/app/data/todo.db')
    cursor = conn.cursor()
    cursor.execute("DELETE FROM tasks WHERE id = ?", (item_id,))
    if cursor.rowcount == 0:
        conn.close()
        raise HTTPException(status_code=404, detail="Task not found")
    conn.commit()
    conn.close()
    return {"message": "Task deleted successfully"}