bot

# Pre-commit

1. run scrips `pre-commit` under sudo, it will install pre-commit
2. to check your code, run `pre-commit run --all-files`

According to task, it should be something like:
```bash
curl -s url/to/install.sh | sh
```
and in `.git/hools/pre-commit` add following:
```bash
if [ "$(git config --get gitleaks.enabled)" != "true" ]; then
  echo "gitleaks is disabled"
  exit 0
fi
```
Verification can be changed by this:
```bash
git config --local gitleaks.enabled true
```

But, unfortunately, I didn't found this: `url/to/install.sh`, and implemented scan based on what I found