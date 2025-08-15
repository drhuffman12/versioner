require "../versioner/updater.cr"
Versioner::Updater.new
  # ToDo: Set the files to be updated to NOT be this repo but your local folder!!!!
  .auto_bump # (replace_old = true)
# .auto_bump(replace_old = true)
