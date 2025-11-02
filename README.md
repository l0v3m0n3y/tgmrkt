# tgmrkt
telegram mini app api mrkt nft nim-lang library
# Example
```nim
import asyncdispatch,tgmrkt,json
waitFor auth("initData")
let data = waitFor get_me()
echo data["fullName"]
```

# Launch (your script)
```
nim c -d:ssl -r  your_app.nim
```
