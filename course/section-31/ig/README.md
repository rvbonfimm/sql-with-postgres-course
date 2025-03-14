# Node project to use the pg-node-migration

### Startup the node project
- `npm init -y`
- `npm install node-pg-migrate pg`

### Set environment variable

`$env:DATABASE_URL="postgres://postgres:<password>@localhost:5432/socialnetwork"`

### Create few migration files
- `npx node-pg-migrate create table comments`
- `npm run migrate create rename column contents to body`

### Execute the migration
- Commit - `npm run migrate up`
- Rollback - `npm run migrate down`
