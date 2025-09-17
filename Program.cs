var builder = WebApplication.CreateBuilder(args); var app = builder.Build();

app.MapGet("/", () => "Hello from updated .NET project on port 8084!");

app.Run();