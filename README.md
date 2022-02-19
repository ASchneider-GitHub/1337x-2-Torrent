# 1337x-2-Torrent
Batch converts [1337x.to](https://1337x.to/) links into torrent files by leveraging:
- The infohash displayed on the torrent's webpage
- Torrent caching services from [itorrents.org](https://itorrents.org/)

Script is called with `./torrentListProcessor.sh <urlString>` where `<urlString>` is a list of 1337x.to torrent page URLs with a space between each one

For example, you would use:
```
./torrentListProcessor.sh https://1337x.to/torrent/torrentID/torrentName1/ https://1337x.to/torrent/torrentID/torrentName2/ https://1337x.to/torrent/torrentID/torrentName3/
```

The script will prompt you for a folder to store torrent files in, and then begin recursively working through the supplied URLs. This can be a slow process, as it depends entirely on both https://1337x.to and https://itorrents.org being responsive to `cURL`.
