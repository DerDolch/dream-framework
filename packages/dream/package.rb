
Package.define("dream-0.1.3") do |package|
	package.fetch_from :url => "https://github.com/ioquatix/dream/tarball/0.1.3", :filename => "dream-0.1.3.tar.gz"
	
	package.depends = ['libogg', 'libpng', 'jpeg', 'freetype']
	
	package.variant(:all) do |platform, config|
		puts YAML::dump(config.build_environment)
		
		RExec.env(config.build_environment) do
			Dir.chdir(package.source_path) do
				sh("rm", "-rf", "build")
				sh("mkdir", "build")
				
				# cmake -DCMAKE_PREFIX_PATH=../../build/darwin_osx/ -DCMAKE_INSTALL_PREFIX:PATH=../../../build/darwin_osx/ .. 
				Dir.chdir("build") do
					cmake_options = []
					cmake_options << "-DCMAKE_INSTALL_PREFIX:PATH=#{platform.prefix}"
					cmake_options << "-DCMAKE_PREFIX_PATH=#{platform.prefix}"
					cmake_options << "-DDREAM_PLATFORM=#{platform.name}"
					cmake_options << "-DDREAM_VARIANT=debug"
					cmake_options << ".."
					
					sh("cmake", "-G", "Unix Makefiles", *cmake_options)
					
					sh("make")
					sh("make", "install")
				end
			end
		end
	end
end



