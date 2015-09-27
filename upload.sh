#!/usr/local/bin/fish

set local_filename $argv[1]
set icon (dirname (status --current-filename))/icon.icns

if test -f $local_filename
  set upload_filename (echo (date +"%s")-(basename $local_filename) | perl -pe 's/[[:blank:]]+/-/g')
  set url "http://czm.io/u/$upload_filename"

  echo $url | pbcopy
  rsync --protect-args --no-perms --no-owner --no-group --chmod=0644 "$local_filename" "jiffybox:sites/czm.io-uploads/$upload_filename"; and \
    /usr/local/bin/terminal-notifier -message "$url" -title "File finished uploading" -appIcon $icon -open "$url"; or \
    /usr/local/bin/terminal-notifier -message "$url" -title "File couldn't be uploaded" -appIcon $icon
end

exit
