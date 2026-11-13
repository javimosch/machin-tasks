# machin-tasks

A get-things-done task list for [machin-365](https://github.com/javimosch/machin-365)
— offline-first, native, single binary. Part of the Machin desktop ecosystem.

- Tasks in local SQLite — works with no account, no server, no network
- Add (Enter or button), toggle done, delete, filter Active/Done/All
- Data lives in `$MACHIN_365_HOME/data/tasks/tasks.db` when installed via the
  suite, `~/.local/share/mdk-tasks/tasks.db` standalone, or `$MDK_TASKS_DB`
- Sync to a machin-bkn server is planned (phase 2)

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
