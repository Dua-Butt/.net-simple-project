var builder = WebApplication.CreateBuilder(args); var app = builder.Build();

app.MapGet("/", () => "Hello from simple .NET project with Nginx!");

app.Run();