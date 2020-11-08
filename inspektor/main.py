import os
from datetime import datetime

import jsonlines
from flask import request
from inspektor import app

IP_DIR = os.environ.get("IP_DIR")


@app.route("/", defaults={"path": ""})
@app.route("/<path:path>")
def index(path):
    ip_files = os.path.join(IP_DIR, "ips.jsonl")

    honey = {request.remote_addr: {k: v for k, v in request.headers}}
    date = datetime.now().strftime("%Y-%m-%d")
    honey[request.remote_addr].update({"date": date})
    honey[request.remote_addr]["args"] = {**request.args}
    honey[request.remote_addr]["path"] = path
    with jsonlines.open(ip_files, mode="a") as ips:
        ips.write(honey)

    return f"<h1>Welcome - TBC!</h1>"


if __name__ == "__main__":
    app.run()
