# ── STAGE 1: Build ───────────────────────
FROM golang:1.22-alpine AS builder
WORKDIR /app

# Cache deps layer separately (only re-runs if go.mod changes)
COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-s -w" -o /app/server .

# ── STAGE 2: Production ──────────────────
FROM gcr.io/distroless/static-debian12
COPY --from=builder /app/server /server
EXPOSE 8000
CMD ["/server"]
