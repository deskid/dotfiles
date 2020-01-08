## install

```
pip install -r requirements.txt
```

## useage

```
sudo chmod a+x daily.py
./daily.py


```

## add as cron job

```
sudo crontab -e
0 10 * * * ~/libs/daily.py
```