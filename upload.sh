#!/usr/local/bin/fish

set local_filename $argv[1]
set icon ~/Google\ Drive/Sites/czmio_icon.png

if test -f $local_filename
  # Upload filename schema: `"[0-9,a-z]{12}\." + original extension`
  set upload_filename (uuidgen | cut -d "-" -f 1-1 | tr '[:upper:]' '[:lower:]').(basename $local_filename | sed 's/.*\.//g')
  set url "https://czm.io/u/$upload_filename"

  echo $url | pbcopy
  cp "$local_filename" "$HOME//Google Drive/Sites/czm.io/u/$upload_filename";
    and ~/Google\ Drive/Sites/czmio_sync.sh;
    and /usr/local/bin/terminal-notifier -title "File finished uploading" -message "$url" -appIcon $icon -open "$url";
    or /usr/local/bin/terminal-notifier -title "File couldn't be uploaded" -message "$local_filename" -appIcon $icon
end
