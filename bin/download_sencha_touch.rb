require 'rubygems'
require 'rubygems/user_interaction'
require 'open-uri'
require 'zip'
require 'fileutils'


def download_sencha_touch(sencha_touch_zip=nil)
  $VERBOSE = true
  size = ""
  sencha_touch_zip = 'http://builds.sencha.com/touch/sencha-touch-2.4.1-gpl.zip'
  puts "Get #{sencha_touch_zip}"
  open( sencha_touch_zip, 
    :content_length_proc => lambda {|t|
      if t && 0 < t
        size = t.to_s
      end
    },
    :progress_proc => lambda {|s|
      print "Downloading #{s} of #{size}                                                      \r"
    },
    "User-Agent" => "Mozilla/5.0 (X11; U; Linux; i686; en-US; rv:1.6) Gecko Debian/1.6-7","Referer" => "http://github.com/AlexVangelov/sencha-touch-rails/") {|zf|
        Zip::File.open(zf.path) do |zipfile|
          zipfile.each{|e|
            print "Extracting #{File.basename(e.to_s)}                                        \r"
            fpath = File.join('sencha-touch', e.to_s)
            FileUtils.mkdir_p(File.dirname(fpath))
            zipfile.extract(e, fpath){ true }
          }
        end
    }
   puts "Download and Extract Sencha Touch [OK]                                                 "
end