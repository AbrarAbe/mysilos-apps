require 'json'

template = File.read("PKGBUILD.template")
git_tag = '0.1'

Dir.glob("*").select { |e| FileTest.directory?(e) && !e.start_with?("_") }.each do |appname|
    info_file = JSON.parse(File.read("#{appname}/info.json"))
    
    dependencies = (['silos'] + info_file['dependencies'].to_a).map { |e| "'#{e}'" }.join(" ")
    
    pkgbuild = template % [appname, info_file['desc'], git_tag, dependencies]
    
    `mkdir -p "_dist/#{appname}"`
    File.open("_dist/#{appname}/PKGBUILD", 'w') do |f|
        f.puts pkgbuild
    end
end