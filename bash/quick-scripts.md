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

---

Find SSH config files in /etc where password authentication is specified

```bash
sudo grep -Rnw '/etc/' -e "PasswordAuthentication yes" | while read line; do [[ "$line" != *"#"* ]] && echo "$line"; done
```

---

Monitor TCP connections. Refreshes every 5 seconds so a terminal can be kept open running this.

```bash
netstat -ac 5 | grep TCP
```

---

Auditing syscalls with auditctl (Installed via install script). This can help find some more difficult stuff.

```bash
auditctl -a exit,always -S execve

ausearch -m execve -i
```

---

Find top talking IP addresses over 1000 packets

```bash
sudo tcpdump -nn -c 1000| awk '{print $3}' | cut -d '.' -f1-4 | sort -n | uniq -c | sort -nr
```

