FROM node:16.10.0-slim

WORKDIR /usr/app

# Install latest chrome dev package and fonts to support major charsets (Chinese, Japanese, Arabic, Hebrew, Thai and a few others)
# Note: this installs the necessary libs to make the bundled version of Chromium that Puppeteer installs, work.
# also installing chrome which is available at: /usr/bin/google-chrome-stable
RUN apt-get update \
    && apt-get install -y procps \
    && apt-get install -y git \
    && apt-get install -y wget gnupg \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
    && apt-get update \
    && apt-get install -y google-chrome-stable fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst fonts-freefont-ttf libxss1 \
      --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# possible to run chrome at "/usr/bin/google-chrome-stable" or using the command:
# CMD ["google-chrome-stable"]

# Settings that work for puppeteer on this container:
# 
# {
#     executablePath: '/usr/bin/google-chrome-stable',
#     headless: true,
#     args: [
#       '--ignore-certificate-errors',
#       '--no-sandbox',
#       '--disable-setuid-sandbox',
#       '--disable-accelerated-2d-canvas',
#       '--disable-gpu'
#     ]
# }