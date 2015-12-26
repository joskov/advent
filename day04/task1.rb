require 'active_support/all'

key = 'bgvyzdsv'

i = 0
loop do
  result = Digest::MD5.hexdigest(key + i.to_s)
  if result.starts_with?('00000')
    print "#{i}\n"
    print "#{result}\n"
    break
  end
  i += 1
end
