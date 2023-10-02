# Quick Scripts and One-liners

These are some quick scripts to use to do quick auditing

---

Finds all users that have shells

```bash
cat /etc/passwd | grep -v /bin/false | grep -v /sbin/nologin
```

---

Find all sudo users

```bash
getent group sudo
```

---

Get all group info on users

```bash
for user in $(getent passwd | grep -v /bin/false | grep -v /sbin/nologin | cut -d: -f1); do id $user; done
```

---

Get the bash history of all users with shells

```bash
for user in $(getent passwd | grep -v /bin/false | grep -v /sbin/nologin | grep -v sync | grep
-v root | cut -d: -f1); do awk -v prefix="$user -> " '{print prefix $0}'
/home/$user/.bash_history; done && awk -v prefix="root -> " '{print prefix $0}'
/root/.bash_history
```

---

Find all authorized keys files

```bash
find / -name authorized_keys 2> /dev/null
```

---

Find id_rsa files

```bash
find / -name id_rsa 2> /dev/null
```

---

Find established/connected network connections

```bash
netstat -anp | grep ESTABLISHED
```

```bash
netstat -anp | grep CONNECTED
```

---

Find all SUID binaries (could be used for red team priv esc)

```bash
find / -uid 0 –perm -4000 –print
```
---

Install pspy tool (could be useful for monitoring processes)

```bash
wget https://github.com/DominicBreuker/pspy/releases/download/v1.2.1/pspy64 && chmod +x pspy64

./pspy64
```