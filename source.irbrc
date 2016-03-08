require 'irb/ext/save-history'
IRB.conf[:SAVE_HISTORY] = 2000
# always save history in the current working dir instead of global
history_file = File.join(Dir.pwd, ".irb-history")
puts "original history in #{IRB.conf[:HISTORY_FILE]}"
IRB.conf[:HISTORY_FILE] = history_file
puts "saving history in #{history_file}"
# cascading irbrcs:
def cascading_irbrcs(path)
  return if (path == ENV["HOME"]) || (path == '/')
  cascading_irbrcs(File.dirname path)
  irbrc = File.join(path, ".irbrc")
  load irbrc if File.exists?(irbrc)
end

# Don't put anymore config after this point, this should be the last line.
cascading_irbrcs Dir.pwd
