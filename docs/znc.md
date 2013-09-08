# ZNC

## What is it?
ZNC is an IRC network bouncer which is left connected so an IRC client can disconnect/reconnect without losing the chat session. At the same time, it allows the user to hide the original source of the user's connection, providing privacy as well as the ability to route traffic through a specific location.

## Configuration

### Password variables

(ZNC uses a sha256 hashed md5hash with a randomly calculated salt, structured in a funny way).

There's 2 possible ways to calculate the ZNC password hashes:

1. run the script `contrib/znc_hash.sh <PASSWORD>` (substitute <PASSWORD> with the actual password)

2. In your shell: run the following command (again: substitute <PASSWORD> with the actual password)

  ```bash
ZNC_PASS = <PASSWORD>
ZNC_SALT="$(dd if=/dev/urandom bs=16c count=1 | md5sum | awk '{print $1}')"
ZNC_HASH="sha256#$(echo -n ${ZNC_PASS}${ZNC_SALT} | sha256sum | awk '{print $1}')#$ZNC_SALT#"
echo $ZNC_PASS
```
