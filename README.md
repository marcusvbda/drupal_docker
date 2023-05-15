## Instalation

Run the commands bellow
```
docker network create web
docker compose up -d --force-recreate
```

If you wanna to reset all settings to reinstall, you need to delete the directory sites/default first
```
sudo rm -r sites/default
```
recreate the database, and then access the localhost:8080 