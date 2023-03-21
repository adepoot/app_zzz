# app_zzz

Shows statistics of the futsal team De Zwarte Zeverzwijnen.


## GitHub pages

To deploy to GitHub pages, follow these steps:

```
rm -rf docs/*
flutter build web --base-href /app_zzz/ --release --quiet
cp -r build/web/* docs
```

Commit and push the changes.