#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;36m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}Starting FTP upload process for KableRecord...${NC}"

# FTP Configuration
FTP_HOST="ftp.kablerecord.com"
FTP_USER="siteftp@kablerecord.com"
FTP_PASS="Circlelight!!"
FTP_DIR="/public_html"

# Local directory (www folder from build)
LOCAL_DIR="$(dirname "$0")/../www"

echo -e "${BLUE}Uploading files from $LOCAL_DIR to $FTP_DIR...${NC}"

# Use lftp to mirror the directory
lftp -c "
set ftp:ssl-allow no
open ftp://$FTP_USER:$FTP_PASS@$FTP_HOST
mirror --reverse \
       --delete \
       --verbose \
       --exclude .DS_Store \
       --exclude .git/ \
       --exclude node_modules/ \
       $LOCAL_DIR $FTP_DIR
bye
"

if [ $? -eq 0 ]; then
    echo -e "${GREEN}FTP upload complete!${NC}"
    echo -e "${BLUE}Your site should now be live at https://kablerecord.com${NC}"
else
    echo -e "${RED}FTP upload failed. Please check your credentials and try again.${NC}"
    exit 1
fi
