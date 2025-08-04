# syntax=docker.io/docker/dockerfile:1.7-labs
FROM python:3.11

ENV DUO_USE_VENV=false
ENV PYTHONUNBUFFERED=true

WORKDIR /app

# Copy the whole project into /app
COPY --exclude=test --exclude=vm . .

# ▸ install helpers ▸ convert CR-LF to LF ▸ make scripts executable ▸ install Python deps
RUN apt-get update -y \
 && apt-get install -y ffmpeg dos2unix \
 && dos2unix /app/*.sh \
 && chmod +x /app/*.sh \
 && pip install --no-cache-dir -r requirements.txt

CMD ["bash", "/app/cron.main.sh"]
