# Simple Proxy for Blowfish API

This Docker image provides an Nginx setup that acts as a reverse proxy, with rate limiting and the ability to add a custom header to all requests. It can be used by wallet customers to prevent user IP addresses from being sent to Blowfish and to avoid exposing their API key to clients. The target of the proxy and the value of the custom header can be configured using environment variables.

## Features
- Acts as a reverse proxy to a backend service.
- Implements configurable rate limiting per IP.
- Injects a custom header (X-Api-Key) based on the BLOWFISH_API_KEY environment variable.

## How to Run:
You can run the Docker image either by using the pre-built image from our Docker repository or by building the image yourself.

### Using the Pre-built Image:
1. Pull the image from the Docker repository:
```bash
docker pull blowfishxyz/simple-proxy:latest
```
2. Run the Docker container with the desired environment variables:
```bash
docker run -d \
  -p 80:80 \
  -e BLOWFISH_API_KEY=<your_api_key> \
  blowfishxyz/simple-proxy:latest
```

Replace <your_api_key> with your API key.

### Building and Running the Image Yourself:

```bash
git clone blowfishxyz/simple-proxy
cd simple-proxy
```

```bash
docker build -t simple-proxy:local .
```

```bash
docker run -d \
  -p 80:80 \
  -e BLOWFISH_API_KEY=<your_api_key> \
  simple-proxy:local
```

### Test that it is working 

```bash
curl --request POST \
     --url 'http://localhost/ethereum/v0/mainnet/historical/transaction' \
     --header 'Content-Type: application/json' \
     --header 'X-Api-Version: 2023-06-05' \
     --header 'accept: application/json' \
     --data '
{
  "userAccount": "0xa725f1a12b69eb32a7aea885c826deffaad6e3f3",
  "txHash": "0x8010da429a651ca117e5c087497cdd8d62e2b7ac1d4095358897817a4d1aa477"
}
'
```

# Rate Limiting:
By default, the rate limiting is set to allow 2 requests per second per IP with a burst of up to 10. You can adjust these settings in the nginx.conf file as needed before building the image.
