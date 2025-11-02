import asyncdispatch, httpclient, json, strutils

const api = "https://api.tgmrkt.io/api/v1"
var headers = newHttpHeaders({"Connection": "keep-alive",  "Host": "api.tgmrkt.io",  "Content-Type": "application/json",  "accept": "application/json, text/plain, */*", "user-agent":"Mozilla/5.0 (Linux; Android 12; K) Telegram-Android/12.1.1 (Samsung SM-S9210; Android 12; SDK 32; AVERAGE)"})

proc auth*(initData:string): Future[void] {.async.} =
  let client = newAsyncHttpClient()
  try:
    client.headers = headers
    let json = %* {"data": initData,"appId":nil}
    let response = await client.post(api & "/auth",body = $json)
    let body = await response.body
    let body_json = parseJson(body)
    headers["Authorization"]= "Bearer " & body_json["token"].getStr()
  finally:
    client.close()

proc get_me*(): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  try:
    client.headers = headers
    let response = await client.get(api & "/me")
    let body = await response.body
    result = parseJson(body)
  finally:
    client.close()

proc get_gifts*(count: int = 20,cursor: string = "",collectionNames: seq[string] = @[],modelNames: seq[string] = @[],backdropNames: seq[string] = @[],symbolNames: seq[string] = @[],number: int = 0,isNew: bool = false,isPremarket: bool = false,luckyBuy: bool = false,giftType: string = "",craftable: bool = false,minPrice: float = 0.0,maxPrice: float = 0.0,ordering: string = "None",lowToHigh: bool = false,query: string = ""): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  try:
    client.headers = headers
    let json = %*{"count": count,"cursor": cursor,"collectionNames": collectionNames,"modelNames": modelNames,"backdropNames": backdropNames,"symbolNames": symbolNames,"number": if number == 0: newJNull() else: %number,"isNew": if not isNew: newJNull() else: %isNew,"isPremarket": if not isPremarket: newJNull() else: %isPremarket,"luckyBuy": if not luckyBuy: newJNull() else: %luckyBuy,"giftType": if giftType.len == 0: newJNull() else: %giftType,"craftable": if not craftable: newJNull() else: %craftable,"minPrice": if minPrice == 0.0: newJNull() else: %minPrice,"maxPrice": if maxPrice == 0.0: newJNull() else: %maxPrice,"ordering": ordering,"lowToHigh": lowToHigh,"query": if query.len == 0: newJNull() else: %query}
    let response = await client.post(api & "/gifts/saling", body = $json)
    let body = await response.body
    result = parseJson(body)
  finally:
    client.close()

proc gifts_models*(collections: seq[string] = @[]): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  try:
    client.headers = headers
    let json = %* {"collections":collections}
    let response = await client.post(api & "/gifts/models",body = $json)
    let body = await response.body
    result = parseJson(body)
  finally:
    client.close()


proc lootbox_list*(): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  try:
    client.headers = headers
    let json = %*{"from":""}
    let response = await client.post(api & "/lootbox-feed", body = $json)
    let body = await response.body
    result = parseJson(body)
  finally:
    client.close()

proc get_locales*(): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  try:
    client.headers = headers
    let response = await client.get(api & "/locales")
    let body = await response.body
    result = parseJson(body)
  finally:
    client.close()

proc get_balance*(): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  try:
    client.headers = headers
    let response = await client.get(api & "/balance")
    let body = await response.body
    result = parseJson(body)
  finally:
    client.close()

proc get_notifications*(): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  try:
    client.headers = headers
    let response = await client.get(api & "/giveaway-notifications")
    let body = await response.body
    result = parseJson(body)
  finally:
    client.close()

proc gift_statistics*(): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  try:
    client.headers = headers
    let response = await client.get(api & "/gift-statistics")
    let body = await response.body
    result = parseJson(body)
  finally:
    client.close()

proc get_competitions*(): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  try:
    client.headers = headers
    let response = await client.get(api & "/competitions")
    let body = await response.body
    result = parseJson(body)
  finally:
    client.close()

proc gifts_collections*(): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  try:
    client.headers = headers
    let response = await client.get(api & "/gifts/collections")
    let body = await response.body
    result = parseJson(body)
  finally:
    client.close()

proc stickers_collections*(): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  try:
    client.headers = headers
    let response = await client.get(api & "/sticker-sets/collections")
    let body = await response.body
    result = parseJson(body)
  finally:
    client.close()

proc lootboxes_categories*(): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  try:
    client.headers = headers
    let response = await client.get(api & "/lootboxes/categories")
    let body = await response.body
    result = parseJson(body)
  finally:
    client.close()

proc channels_gifts*(): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  try:
    client.headers = headers
    let response = await client.get(api & "/channels/gifts?all=true")
    let body = await response.body
    result = parseJson(body)
  finally:
    client.close()

proc check_validations*(id:string): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  try:
    client.headers = headers
    let response = await client.get(api & "/giveaways/check-validations/" & id)
    let body = await response.body
    result = parseJson(body)
  finally:
    client.close()

proc get_giveaways*(id:string): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  try:
    client.headers = headers
    let response = await client.get(api & "/giveaways/" & id)
    let body = await response.body
    result = parseJson(body)
  finally:
    client.close()

proc get_stickers*(id:string): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  try:
    client.headers = headers
    let response = await client.get(api & "sticker-sets/set/" & id)
    let body = await response.body
    result = parseJson(body)
  finally:
    client.close()

proc get_lootboxes*(endpoint: string = "new",category: string = "",count: int = 20,cursor: string = ""): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  try:
    client.headers = headers
    var url: string
    if endpoint == "by-creator":
      url = api & "/lootboxes/by-creator?count=" & $count
    elif endpoint == "new":
      url = api & "/lootboxes/new?count=" & $count & "&cursor=" & cursor
    elif endpoint == "creators":
      url = api & "/lootboxes/creators?count=" & $count & "&cursor=" & cursor
    elif endpoint == "categories":
      url = api & "/lootboxes/categories/" & category & "?count=" & $count & "&cursor=" & cursor
    let response = await client.get(url)
    let body = await response.body
    result = parseJson(body)
  finally:
    client.close()
