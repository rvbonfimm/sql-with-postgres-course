# Handling concurrency & Reversibility with transactions

### Commands
- `BEGIN;` - start the transaction session
- `COMMIT` - to kind of a publish the changes
- `ROLLBACK` - to ignore the changes made during the current session

### An important note
The transaction respects the current connection established in the postgres.
Thinking that we have four connections and opens transaction only in the #1 connection:

> 1) Transaction opened - Original value shown could be changed only to this connection
> 2) Original value shown
> 3) Original value shown
> 4) Original value shown

### An example - Banking account deposit/withdrawal

ID  NAME      BALANCE
1	"Gia"	  100
2	"Alyson"  100

> 1) Withdraw $50 from "Alyson"
> 2) Transfer $50 to "Gia"

`BEGIN;

UPDATE accounts
SET balance = balance - 50
WHERE name = 'Alyson';

UPDATE accounts
SET balance = balance + 50
WHERE name = 'Gia';

COMMIT;`
