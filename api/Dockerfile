# Build Stage
FROM microsoft/aspnetcore-build:2 as build-env
WORKDIR /api

COPY api.csproj .
RUN dotnet restore

COPY . .
RUN dotnet publish -o /publish



# Runtime Image Setup
FROM microsoft/aspnetcore:2
WORKDIR /publish

COPY --from=build-env /publish /publish
ENTRYPOINT ["dotnet", "api.dll"]
