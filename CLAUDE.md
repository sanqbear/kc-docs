# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Knowledge Center is a monorepo containing:
- **server**: Go REST API backend with chi router and PostgreSQL
- **client**: Vue 3 + TypeScript + Vite frontend
- **db**: PostgreSQL schema definitions

## Common Commands

### Backend (server/)
```bash
make build        # Build the application (outputs ./main)
make run          # Run the application
make test         # Run all tests
make itest        # Run integration tests (testcontainers for PostgreSQL)
make watch        # Live reload development (requires air)
make docker-run   # Start PostgreSQL container
make docker-down  # Stop PostgreSQL container
make swag         # Generate Swagger documentation
```

### Frontend (client/)
```bash
npm run dev       # Start Vite dev server
npm run build     # Type check and build for production
npm run preview   # Preview production build
```

## Architecture

### Backend (Go API)

Uses Domain-Driven Design with Dependency Injection. All dependencies are assembled in `cmd/api/main.go`.

```
server/
  cmd/api/main.go              # Entry point, DI root, Swagger annotations
  internal/
    server/
      server.go                # HTTP server with timeouts (10s read, 30s write, 1m idle)
      routes.go                # Chi router, middleware (Logger, CORS, Swagger)
    database/database.go       # PostgreSQL via pgx, singleton pattern
    auth/                      # Authentication (JWT, password hashing, middleware)
    users/                     # User domain (CRUD operations)
    rbac/                      # Role-based access control, permission middleware
    tickets/                   # Ticketing system domain
  docs/                        # Generated Swagger docs (make swag)
  wiki/                        # Domain documentation (users.md, auth.md)
```

**Pattern per domain**: model.go → repository.go → service.go → handler.go → handler_test.go

**Authentication**: JWT-based with 15-min access tokens and 7-day refresh tokens (HTTP-only cookie). Roles inherited from `user_roles` and `group_roles` tables.

### Frontend (Vue 3)

```
client/
  src/
    views/                     # Page components (Login, Register, Home, tickets/)
    components/                # Reusable components
    stores/                    # Pinia stores (auth.ts, ticket.ts)
    router/index.ts            # Vue Router configuration
    i18n/                      # vue-i18n (Korean, English)
    utils/api.ts               # API client utilities
    types/                     # TypeScript types (auth.ts, ticket.ts)
```

Uses Tailwind CSS 4 for styling.

### Database Schema (db/)

PostgreSQL 18+. Schema files organized by domain:
- `organizations/` - users, groups, roles, user_tokens, departments
- `ticket_systems/` - tickets, ticket_entries, tags, related_tags
- `managements/` - api_permissions for RBAC

## Environment Variables

Backend requires `.env` file (copy from `.env.sample`):
- `PORT` - HTTP server port
- `DB_HOST`, `DB_PORT`, `DB_DATABASE`, `DB_USERNAME`, `DB_PASSWORD`, `DB_SCHEMA`
- `ENCRYPTION_KEY` - AES-256-GCM for user contact encryption
- `JWT_SECRET` - JWT signing key

## API Documentation

- Swagger UI: `http://localhost:8080/swagger/index.html`
- See [server/wiki/SWAG_GUIDELINES.md](server/wiki/SWAG_GUIDELINES.md) for annotation conventions
- Run `make swag` after modifying handler annotations
