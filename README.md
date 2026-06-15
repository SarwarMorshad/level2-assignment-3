# Football Ticket Booking System — Database Design & SQL

A simple database project for a football ticket booking system. It manages
football fans, tournament matches, and individual ticket bookings.

Built with **PostgreSQL** and tested in **Beekeeper Studio**.

## Tables

| Table | Description |
|-------|-------------|
| **Users** | Football fans and ticket managers who use the platform |
| **Matches** | Tournament matches with fixtures, category, price, and status |
| **Bookings** | Ticket purchases linking a user to a match |

**Relationships**
- One **User** → many **Bookings**
- One **Match** → many **Bookings** (many Bookings → one Match)

## ERD

![ERD](Football%20Ticket%20Booking%20System.drawio.png)

## Files

| File | What it contains |
|------|------------------|
| `QUERY.sql` | Table creation (DDL), sample data, and all 7 queries |
| `Football Ticket Booking System.drawio` | Editable ERD source (open in draw.io) |
| `Football Ticket Booking System.drawio.png` | ERD image |

## How to run

1. Open `QUERY.sql` in Beekeeper Studio (connected to PostgreSQL).
2. Run the whole file once — it drops old tables, creates the 3 tables,
   and inserts the sample data (12 rows per table).
3. Highlight any single query at the bottom and run it to see its result.

> Note: the file starts with `DROP TABLE IF EXISTS ...`, so re-running the
> whole file rebuilds everything fresh.

## Queries (Part 2)

1. Champions League matches that are `Available` — `WHERE` + `AND`
2. Users whose name starts with `Tanvir` or contains `Haque` — `ILIKE`
3. Bookings with missing payment status shown as `Action Required` — `IS NULL`, `COALESCE`
4. Booking details with user name and fixture — `INNER JOIN`
5. All users with their bookings, including those with none — `LEFT JOIN`
6. Bookings costing more than the average — subquery with `AVG`
7. Top 2 most expensive matches, skipping the highest — `ORDER BY`, `LIMIT`, `OFFSET`

## Links

- **ERD (public):** https://drive.google.com/drive/folders/14S9rKXDjYILNzpgx4Ic5Doqhj6T9B5iK?usp=sharing
- **GitHub repo:** https://github.com/SarwarMorshad/level2-assignment-3
