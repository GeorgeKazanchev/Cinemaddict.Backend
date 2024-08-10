using Cinemaddict.Backend;
using Cinemaddict.DatabaseAccess.Repository;

var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

var repository = new PostgreSqlRepository("User Id=test; Password=test; Host=localhost; Port=5432; Database=Cinemaddict;");
var requestHandler = new RequestHandler(repository);

app.Run(requestHandler.HandleRequest);
app.Run();