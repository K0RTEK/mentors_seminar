from http.server import HTTPServer, BaseHTTPRequestHandler

class SimpleHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header("Content-type", "text/plain; charset=utf-8")
        self.end_headers()
        self.wfile.write(b"Hello from Docker!")

if __name__ == "__main__":
    from os import environ
    port = int(environ.get("PORT", 8000))
    server = HTTPServer(("0.0.0.0", port), SimpleHandler)
    print(f"Server running on port {port}")
    server.serve_forever()