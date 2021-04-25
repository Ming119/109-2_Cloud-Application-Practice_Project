require('dotenv').config();

module.exprots = {
    mysql: {
        host:     process.env.HOST,
        user:     process.env.DATABASE_USER,
        password: process.env.DATABASE_PASSWORD,
        database: process.env.DATABASE
    }
}
