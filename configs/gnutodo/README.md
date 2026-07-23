# GNU Todo

A todo manager with both a command-line and web interface. An experiment in basic AJAX approaches.

## Setup

1. Run `./install.sh` (installs to `~/.local/bin/gtd` and creates `~/Documents/todo.txt`)
2. Or manually: `cp gtd ~/.local/bin/gtd && chmod +x ~/.local/bin/gtd`

## CLI Usage

```
./gtd -a -l "task description" -p project -c context   # add
./gtd -e <index> -p newproject                          # edit
./gtd -d <index>                                        # mark done
./gtd -r <index>                                        # remove
./gtd -C                                                # archive done items
```

Filters: `-s` (status: a/w/d), `-i` (importance: 0-3), `-t` (timestamp), `-p` (project), `-c` (context)

## Browser Usage

The script doubles as a CGI script. Run it behind any web server with CGI support:

```bash
# Python CGI server (quick test)
cd /path/to/gnutodo
mkdir cgi-bin && cp gtd cgi-bin/gtd && chmod +x cgi-bin/gtd
python3 -W ignore -m http.server --cgi 8080
# Open http://localhost:8080/cgi-bin/gtd
```

```bash
# Apache
sudo cp gtd /usr/lib/cgi-bin/
sudo chmod +x /usr/lib/cgi-bin/gtd
# http://localhost/cgi-bin/gtd
```

```bash
# lighttpd
sudo cp gtd /usr/lib/cgi-bin/
sudo chmod +x /usr/lib/cgi-bin/gtd
# Ensure mod_cgi is enabled, then http://localhost/cgi-bin/gtd
```

The web interface supports context/project filtering, add/edit/done/remove, due dates, importance levels, and status toggling.

## Dependencies

- **zsh** — the script runtime
- **ncal** — (optional) for the calendar date picker in the web UI: `sudo apt install ncal`

## Files

- `gtd` — the script (zsh)
- `install.sh` — installer
- `~/Documents/todo.txt` — default todo file

## Links

- https://git.code.sf.net/p/gnutodo/code
- https://sourceforge.net/p/gnutodo/code/ci/master/tree/

