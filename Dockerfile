FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 5000
ENV ASPNETCORE_URLS=http://+:5000

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY ["SimpleDotNetProject.csproj", "./"]
RUN dotnet restore "SimpleDotNetProject.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "SimpleDotNetProject.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "SimpleDotNetProject.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "SimpleDotNetProject.dll"]



# FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
# WORKDIR /app
# EXPOSE 5000
# ENV ASPNETCORE_URLS=http://+:5000

# FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
# WORKDIR /src
# COPY ["WrongName.csproj", "./"]  # Intentional error: galat project file name
# RUN dotnet restore "SimpleDotNetProject.csproj"  # Yeh fail hoga kyunki file nahi milegi
# COPY . .
# WORKDIR "/src/."
# RUN dotnet build "SimpleDotNetProject.csproj" -c Release -o /app/build

# FROM build AS publish
# RUN dotnet publish "SimpleDotNetProject.csproj" -c Release -o /app/publish /p:UseAppHost=false

# FROM base AS final
# WORKDIR /app
# COPY --from=publish /app/publish .
# ENTRYPOINT ["dotnet", "SimpleDotNetProject.dll"]