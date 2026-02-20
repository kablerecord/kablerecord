#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;36m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}Starting complete cleanup and deployment for KableRecord...${NC}"

# FTP Configuration
FTP_HOST="ftp.kablerecord.com"
FTP_USER="kableftp@kablerecord.com"
FTP_PASS="Sup3r7\$\$!"
FTP_DIR="/www.kablerecord.com"

# Local directory (www folder from build)
LOCAL_DIR="$(dirname "$0")/../www"

echo -e "${YELLOW}Step 1: Recursively deleting ALL files and folders from server...${NC}"

# Use lftp to recursively delete everything
lftp -c "
set ftp:ssl-allow no
open ftp://$FTP_USER:$FTP_PASS@$FTP_HOST
cd $FTP_DIR
cls -1 | xargs -n 1 rm -rf
bye
"

if [ $? -eq 0 ]; then
    echo -e "${GREEN}All old files and folders deleted successfully!${NC}"
else
    echo -e "${YELLOW}Warning: Some files may not have been deleted, continuing anyway...${NC}"
fi

echo -e "${YELLOW}Step 2: Uploading fresh site files...${NC}"
echo -e "${BLUE}Uploading files from $LOCAL_DIR to $FTP_DIR...${NC}"

# Use lftp to mirror the directory
lftp -c "
set ftp:ssl-allow no
open ftp://$FTP_USER:$FTP_PASS@$FTP_HOST
mirror --reverse \
       --verbose \
       --exclude .DS_Store \
       --exclude .git/ \
       --exclude node_modules/ \
       $LOCAL_DIR $FTP_DIR
bye
"

if [ $? -eq 0 ]; then
    echo -e "${GREEN}==================================================${NC}"
    echo -e "${GREEN}FTP upload complete!${NC}"
    echo -e "${BLUE}Your new site should now be live at https://kablerecord.com${NC}"
    echo -e "${YELLOW}Note: Clear your browser cache or use incognito mode to see changes.${NC}"
    echo -e "${GREEN}==================================================${NC}"
else
    echo -e "${RED}FTP upload failed. Please check your credentials and try again.${NC}"
    exit 1
fi
