
# Ryba Docs

Source code for the [Ryba website](http://www.ryba.io).

## Getting Started

```bash
git clone https://github.com/ryba-io/ryba-www.git ryba-www
cd ryba-www
cat /root/.bowerrc
npm install
# Build the container
docker build -t ryba-www .
# Start nginx unless already running
docker run -d -p 91.121.35.92:80:80 -v /var/run/docker.sock:/tmp/docker.sock:ro jwilder/nginx-proxy
# Serve the CSV documentation
docker run -e VIRTUAL_HOST=ryba.io -d -p 3000 ryba-www
```
