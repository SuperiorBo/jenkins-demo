FROM mcr.microsoft.com/dotnet/core/aspnet:2.2-stretch-slim AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/core/sdk:2.2-stretch AS build
WORKDIR /src
COPY ["src/JenkinsDemo/JenkinsDemo.csproj", "JenkinsDemo/"]
RUN dotnet restore "src/JenkinsDemo/JenkinsDemo.csproj"
COPY . .
WORKDIR /src/JenkinsDemo
RUN dotnet build "JenkinsDemo.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "JenkinsDemo.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "JenkinsDemo.dll"]