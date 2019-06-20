# 2fash

simple 2fa bash client

### Installation

**Dependencies:**
- `oath-toolkit`
- `gnupg`

**Using curl**
```sh
curl -s https://gitlab.com/expexes/2fash/raw/master/remote-install.sh | bash
```

**Using git**
```sh
git clone https://gitlab.com/expexes/2fash.git
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
2fash init
```

**Get code:**
```sh
2fash code [ACCOUNT]
```

**List accounts**
```sh
2fash list
```
