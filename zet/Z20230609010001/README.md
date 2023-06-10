# Generate SSH key for github and configure git

```bash
ssh-keygen -t rsa -b 4096 -C "github_email@example.com"
```

Press enter to accept the default location and set a passphrase 
for added security.

**Add public key to github**

>  Copy the entire output of the following command and add it
> to your github account via settings -> SSH and GPG keys.

```bash
cat ~/.ssh/id_rsa.pub
```

**Configure Git**
```bash
git config --global user.name "Your Name"
git config --global user.email "github_email@example.com"
```

**Test connection**
```bash
ssh -T git@github.com
```

https://www.google.com/search?q=ssh+github+setup

    #sshkeygen #git #github

