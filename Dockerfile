# build stage
FROM microsoft/aspnetcore-build:2 AS build-env
WORKDIR /generator

# restore
COPY generator.sln .
COPY api/api.csproj ./api/
COPY tests/tests.csproj ./tests/
RUN dotnet restore
# copy src

COPY . .

# test
RUN dotnet test tests
# publish
RUN dotnet publish api/api.csproj -o /publish
# runtime
FROM microsoft/aspnetcore:2
COPY --from=build-env /publish /publish
WORKDIR /publish
ENTRYPOINT ["dotnet", "api.dll"]

