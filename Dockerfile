FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
WORKDIR /app

COPY . ./
RUN dotnet restore

COPY . ./
RUN dotnet publish -c Release -o publish

FROM mcr.microsoft.com/dotnet/core/aspnet:3.1
WORKDIR /app
COPY --from=build /app/publish .
#ENRTYPOINT ["dotnet", "SQ009Demo.dll"]
CMD ASPNETCORE_URLS=http://*:$PORT dotnet SQ009Demo.dll