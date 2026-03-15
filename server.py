#!/usr/bin/env python3
"""
Simple HTTP server for Kids Music Player
Run this script to test the application locally before deploying to Raspberry Pi
"""

import http.server
import os
import socketserver
import sys

# Configuration
PORT = 8000


class MyHTTPRequestHandler(http.server.SimpleHTTPRequestHandler):
    def end_headers(self):
        # Add headers to prevent caching during development
        self.send_header("Cache-Control", "no-store, no-cache, must-revalidate")
        self.send_header("Expires", "0")
        super().end_headers()

    def log_message(self, format, *args):
        # Customize log format
        sys.stdout.write(
            "%s - - [%s] %s\n"
            % (self.address_string(), self.log_date_time_string(), format % args)
        )


def main():
    # Change to script directory
    script_dir = os.path.dirname(os.path.abspath(__file__))
    os.chdir(script_dir)

    print("=" * 60)
    print("Kids Music Player - Development Server")
    print("=" * 60)
    print(f"Serving files from: {script_dir}")
    print(f"Server running on port: {PORT}")
    print()
    print("Access the application at:")
    print(f"  http://localhost:{PORT}")
    print(f"  http://127.0.0.1:{PORT}")
    print()
    print("Press Ctrl+C to stop the server")
    print("=" * 60)
    print()

    # Create server
    Handler = MyHTTPRequestHandler

    try:
        with socketserver.TCPServer(("", PORT), Handler) as httpd:
            httpd.serve_forever()
    except KeyboardInterrupt:
        print("\n\nServer stopped.")
        sys.exit(0)
    except OSError as e:
        if e.errno == 98 or e.errno == 10048:  # Address already in use
            print(f"\nError: Port {PORT} is already in use.")
            print("Please close the other application or choose a different port.")
            sys.exit(1)
        else:
            raise


if __name__ == "__main__":
    main()
