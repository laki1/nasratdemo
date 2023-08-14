module.exports = {
    options: {
      connection: "postgres://postgres:postgres@127.0.0.1:1234/nasratdemo",
      schema: ["public"],
      watch: true,
      enhanceGraphiql: true,
      enableCors: true,
      cors: true,
      host: "127.0.0.1",
      port: "5500"
    },
  };