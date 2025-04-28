const pg = require('pg');

const pool = new pg.Pool({
    host: 'localhost',
    port: 5432,
    database: 'socialnetwork',
    user: 'postgres',
    password: '123mudar'
});

pool
    .query(`
        UPDATE posts
        SET loc = POINT(lng, lat)
        WHERE loc IS NULL;
    `)
    .then(() => {
        console.log('Update completely!!!')
        pool.end();
    })
    .catch(err => console.error(err));
