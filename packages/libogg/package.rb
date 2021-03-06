
Package.define("libogg-1.3.0") do |package|
	package.fetch_from :url => "http://downloads.xiph.org/releases/ogg/libogg-1.3.0.tar.gz"
	
	package.build(:all) do |platform, config|
		RExec.env(config.build_environment) do
			Dir.chdir(package.source_path) do
				sh("make", "clean") if File.exist? "Makefile"
				
				sh("./configure", "--prefix=#{platform.prefix}", "--disable-dependency-tracking", "--enable-shared=no", "--enable-static=yes", *config.configure)
				sh("make install")
			end
		end
		
		sh("cp", "FindOgg.cmake", platform.cmake_modules_path.to_s)
	end
end
