# 2fash

simple 2fa bash tool

### Installation

**Dependencies:**
- `oath-toolkit`
- `gnupg`
- `xclip` *(optional)*

**Using curl:**
```sh
curl -s https://gitlab.com/kohutd/2fash/raw/master/remote-install.sh | bash
```

**Using git:**
```sh
git clone https://gitlab.com/kohutd/2fash.git
cd 2fash
bash install.sh
```



### Usage

**Get help:**
```sh
2fash help
```

**Create account:**
```sh
2fash add
```

**Get code:**
```sh
2fash code [ACCOUNT]
```

**List accounts:**
```sh
2fash list
```
