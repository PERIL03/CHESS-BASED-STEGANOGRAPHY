import multiprocessing
import os

# Bind to all interfaces on PORT env var (default 8000)
bind = f"0.0.0.0:{int(os.getenv('PORT', '8000'))}"

# Worker settings
workers = int(os.getenv('WEB_CONCURRENCY', multiprocessing.cpu_count() * 2 + 1))
threads = int(os.getenv('GUNICORN_THREADS', 2))
worker_class = os.getenv('GUNICORN_WORKER_CLASS', 'gthread')

# Timeouts
timeout = int(os.getenv('GUNICORN_TIMEOUT', 60))
keepalive = int(os.getenv('GUNICORN_KEEPALIVE', 5))

# Access log to stdout for PaaS observability
accesslog = '-'
errorlog = '-'
loglevel = os.getenv('LOG_LEVEL', 'info')

# Proxy and forwarded headers
forwarded_allow_ips = '*'
proxy_allow_ips = '*'
