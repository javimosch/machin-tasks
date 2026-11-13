# machin-tasks

A get-things-done task list for [machin-365](https://github.com/javimosch/machin-365)
— offline-first, native, single binary. Part of the Machin desktop ecosystem.

- Two data backends, picked automatically at launch (sticky for the session):
  - **local bkn** (preferred): the suite-managed bkn at
    `$MACHIN_365_HOME/config.json` → `local_port`/`local_token`, collection
    `m365/tasks`. `machin-365 run` auto-starts the service; changes made by
    `machin-365 sync` appear within ~5s. Every write stamps `_mtime` for
    last-writer-wins sync.
  - **SQLite fallback**: `$MDK_TASKS_DB` >
    `$MACHIN_365_HOME/data/tasks/tasks.db` > `~/.local/share/mdk-tasks/tasks.db`
    — used when no bkn endpoint is configured or reachable.
- Force a backend with `MDK_TASKS_BACKEND=bkn|sqlite`, or point at any bkn
  with `MDK_TASKS_BKN_URL` + `MDK_TASKS_BKN_TOKEN`.
- Note: **deletes do not propagate through suite sync yet** (tombstones
  pending) — a task deleted locally can reappear after sync.
- Add (Enter or button), toggle done, delete, filter Active/Done/All

## Build

Requires a [machin-desktop](https://github.com/javimosch/machin-desktop)
checkout (framework + SDL3/OpenGL host + `mdk` tool) and `machin` on PATH:

```sh
git clone https://github.com/javimosch/machin-tasks
cd machin-tasks && ./build.sh        # → build/machin-tasks (~2.6 MB)
```

`MDK_DESKTOP=/path/to/machin-desktop` overrides the default `~/ai/machin-desktop`.

## Develop

```sh
~/ai/machin-desktop/mdk dev app/      # hot reload, state kept across edits
~/ai/machin-desktop/mdk shot app/ out.ppm   # render frames to a screenshot
~/ai/machin-desktop/mdk check app/    # typecheck only
```

## License

MIT
