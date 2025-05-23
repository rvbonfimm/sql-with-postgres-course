const express = require('express');
const pg = require('pg');

const pool = new pg.Pool({
    host: 'localhost',
    port: 5432,
    database: 'socialnetwork',
    user: 'postgres',
    password: '123mudar'
});

/** Check for successful connection */
// pool
//     .query('SELECT 1 + 1')
//     .then((res) => console.log(res));

const app = express();

/**  */
app.use(express.urlencoded({ extended: true }));

app.get('/posts', async (req, res) => {
    const { rows } = await pool.query(`SELECT * FROM posts;`);

    res.send(`
        <table>
            <thead>
                <tr>
                    <th>id</th>
                    <th>lng</th>
                    <th>lat</th>
                </tr>
            </thead>
            <tbody>
                ${rows.map(row => {
        return `
            <tr>
                <td>${row.id}</td>
                <td>${row.loc.y}</td>
                <td>${row.loc.x}</td>
            </tr>`
    }).join('')}
            </tbody>
        </table>
        <form method="POST">
            <h3>Create Post</h3>
            <div>
                <label>Lng</label>
                <input name="lng" />
            </div>
            <div>
                <label>Lat</label>
                <input name="lat" />
            </div>

            <button type="submit">Create</button>
        </form>
    `);
})

app.post('/posts', async (req, res) => {
    const { lat, lng } = req.body;

    const loc = `(${lng}, ${lat})`;

    /** Avoid SQL injection */
    await pool.query('INSERT INTO posts (loc) VALUES ($1)',
        [loc]
    );

    res.redirect('/posts')
})

app.listen(3005, () => {
    console.log(`Listening on port 3005`);
})