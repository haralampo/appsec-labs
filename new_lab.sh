#!/usr/bin/env bash
# new_lab.sh - scaffold a new PortSwigger lab writeup
#
# Usage:
#   ./new_lab.sh <category-folder> <lab-slug>
#
# Example:
#   ./new_lab.sh 02_cross_site_scripting reflected_nothing_encoded
#
# category-folder must match an existing numbered folder exactly
# (e.g. 01_sql_injection, 02_cross_site_scripting) - this script does
# not create new category folders, only lab subfolders inside them.
#
# Fill in [Lab Title], the Lab-Link URL, [APPRENTICE]/[PRACTITIONER],
# and the Exploitation narrative by hand after it's created.
# Run this from the root of your appsec-labs repo.

set -euo pipefail

BASE_DIR="."

if [ "$#" -lt 2 ]; then
  echo "Usage: $0 <category-folder> <lab-slug>"
  echo "Example: $0 02_cross_site_scripting reflected_nothing_encoded"
  exit 1
fi

CATEGORY="$1"
SLUG="$2"

if [ ! -d "${BASE_DIR}/${CATEGORY}" ]; then
  echo "Error: category folder '${CATEGORY}' doesn't exist in $(pwd)."
  echo "Existing categories:"
  ls -d "${BASE_DIR}"/*/ 2>/dev/null | xargs -n1 basename
  exit 1
fi

LAB_DIR="${BASE_DIR}/${CATEGORY}/${SLUG}"

if [ -d "$LAB_DIR" ]; then
  echo "Error: ${LAB_DIR} already exists. Pick a different slug or remove it first."
  exit 1
fi

mkdir -p "${LAB_DIR}/img"

cat > "${LAB_DIR}/README.md" << 'EOF'
# Write-up: [Lab Title] @ PortSwigger Academy

![Lab title](img/title.png)

Lab-Link: <https://portswigger.net/web-security>  
Difficulty: APPRENTICE

![Lab description](img/description.png)

## Exploitation
I was told there was an XSS vulnerability in the search functionality, so I inserted a script in hopes that my text is directly echoed and run: 

`code`

Upon return, I received a success message:

![Success banner](img/success.png)
EOF

echo "Created ${LAB_DIR}/"
echo "  - README.md"
echo "  - img/"