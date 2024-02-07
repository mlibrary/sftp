#!/bin/bash

if [ -f ".git/hooks/pre-commit" ]; then
  echo "🪝 .git/hooks/pre-commit exists. Leaving alone"
else
  echo "🪝 .git/hooks/pre-commit does not exist. Copying .github/pre-commit to .git/hooks/"
  cp .github/pre-commit .git/hooks/pre-commit
fi

echo "🚢 Build docker images"
docker compose build

echo "🔑 Set up development keys"
./bin/set_up_development_ssh_keys.sh
