# Schema vs Data migrations

Schema was previously explained and now, we're discussing data migrations.

There are one scenario where we'll need to define a strategy to the migrations:

- Schema & Data migration at the same time

Proposal:

> Transform columns latitude (lat) & longitude (lng) to a pointer type column loc (example (30, 50))

1. Add new column (loc in this case)
2. Deploy new version of API population values to both lat/lgn & loc columns
3. Copy lat/lng values to loc
4. Update API to only write to loc column
5. Drop columns lat/lng, remaining only the new column loc
