import socket
import time
import sys

def is_port_open(host: str, port: int) -> bool:
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        s.settimeout(1)  # Timeout for the connection attempt
        return s.connect_ex((host, port)) == 0

def wait_for_port(host: str, port: int, interval: int = 5):
    print(f"Checking if port {port} is open on {host}...")
    while True:
        if is_port_open(host, port):
            print(f"Port {port} is open! Exiting.")
            break
        print(f"Port {port} is still closed. Retrying in {interval} seconds...")
        time.sleep(interval)

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python script.py IPADDRESS")
        sys.exit(1)
    
    TARGET_HOST = sys.argv[1]
    TARGET_PORT = 9026
    CHECK_INTERVAL = 1  # Time in seconds between checks
    
    wait_for_port(TARGET_HOST, TARGET_PORT, CHECK_INTERVAL)