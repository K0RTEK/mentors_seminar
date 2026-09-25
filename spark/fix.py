import json

with open("marts..ipynb", "r", encoding="utf-8-sig") as f:  # utf-8-sig убирает BOM
    nb = json.load(f)

nb["metadata"]["kernelspec"] = {
    "display_name": "PySpark",
    "language": "python",
    "name": "pyspark"
}

with open("marts..ipynb", "w", encoding="utf-8") as f:  # сохраняем без BOM
    json.dump(nb, f, indent=1)