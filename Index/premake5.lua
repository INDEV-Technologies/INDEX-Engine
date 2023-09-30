IncludeDir = {}
IncludeDir["entt"] = "External/entt/src/"
IncludeDir["GLFW"] = "External/glfw/include/"
IncludeDir["Glad"] = "External/glad/include/"
IncludeDir["lua"] = "External/lua/src/"
IncludeDir["stb"] = "External/stb/"
IncludeDir["OpenAL"] = "External/OpenAL/include/"
IncludeDir["Box2D"] = "External/box2d/include/"
IncludeDir["external"] = "External/"
IncludeDir["vulkan"] = "External/vulkan/"
IncludeDir["Lumos"] = "Source"
IncludeDir["External"] = "External/"
IncludeDir["ImGui"] = "External/imgui/"
IncludeDir["freetype"] = "External/freetype/include"
IncludeDir["SpirvCross"] = "External/SPIRV-Cross"
IncludeDir["cereal"] = "External/cereal/include"
IncludeDir["spdlog"] = "External/spdlog/include"
IncludeDir["glm"] = "External/glm"
IncludeDir["msdf_atlas_gen"] = "External/msdf-atlas-gen/msdf-atlas-gen"
IncludeDir["msdfgen"] = "External/msdf-atlas-gen/msdfgen"
IncludeDir["ozz"] = "External/ozz-animation/include"

project "Lumos"
	kind "StaticLib"
	language "C++"
	editandcontinue "Off"
		staticruntime "Off"
	files
	{
		"Source/**.h",
		"Source/**.c",
		"Source/**.cpp"
	}

	removefiles
	{
		"Source/Lumos/Platform/**"
	}

	includedirs
	{
		"",
		"../",
		"Source/",
		"Source/Lumos",
		"Assets/Shaders"
	}

	externalincludedirs
	{
		"%{IncludeDir.entt}",
		"%{IncludeDir.GLFW}",
		"%{IncludeDir.Glad}",
		"%{IncludeDir.lua}",
		"%{IncludeDir.stb}",
		"%{IncludeDir.ImGui}",
		"%{IncludeDir.OpenAL}",
		"%{IncludeDir.Box2D}",
		"%{IncludeDir.vulkan}",
		"%{IncludeDir.external}",
		"%{IncludeDir.External}",
		"%{IncludeDir.spdlog}",
		"%{IncludeDir.freetype}",
		"%{IncludeDir.SpirvCross}",
		"%{IncludeDir.cereal}",
		"%{IncludeDir.glm}",
		"%{IncludeDir.msdfgen}",
		"%{IncludeDir.msdf_atlas_gen}",
		"%{IncludeDir.ozz}",
		"%{IncludeDir.Lumos}",
	}

	links
	{
		"lua",
		"box2d",
		"imgui",
		"freetype",
		"SpirvCross",
		"spdlog",
		"meshoptimizer",
		-- "msdfgen",
		"msdf-atlas-gen",
		"ozz_base",
		"ozz_animation",
		"ozz_animation_offline"
	}

	defines
	{
		"LUMOS_ENGINE",
		"FREEIMAGE_LIB",
		"IMGUI_USER_CONFIG=\"Source/Lumos/ImGui/ImConfig.h\"",
		"SPDLOG_COMPILED_LIB",
		"GLM_FORCE_INTRINSICS",
		"GLM_FORCE_DEPTH_ZERO_TO_ONE"
	}

	filter 'architecture:x86_64'
		defines { "USE_VMA_ALLOCATOR"}

	filter "system:windows"
		cppdialect "C++17"
		systemversion "latest"
		disablewarnings { 4307 }
		characterset ("Unicode")
		conformancemode "on"
		pchheader "Precompiled.h"
		pchsource "Source/Precompiled.cpp"

		defines
		{
			"LUMOS_PLATFORM_WINDOWS",
			"LUMOS_RENDER_API_OPENGL",
			"LUMOS_RENDER_API_VULKAN",
			"VK_USE_PLATFORM_WIN32_KHR",
			"WIN32_LEAN_AND_MEAN",
			"_CRT_SECURE_NO_WARNINGS",
			"_DISABLE_EXTENDED_ALIGNED_STORAGE",
			"_SILENCE_CXX17_OLD_ALLOCATOR_MEMBERS_DEPRECATION_WARNING",
			"_SILENCE_CXX17_ITERATOR_BASE_CLASS_DEPRECATION_WARNING",
			"LUMOS_IMGUI",
			"LUMOS_OPENAL",
			"LUMOS_VOLK",
			"LUMOS_USE_GLFW_WINDOWS"
		}

		files
		{
			"Source/Lumos/Platform/Windows/*.h",
			"Source/Lumos/Platform/Windows/*.cpp",

			"Source/Lumos/Platform/GLFW/*.h",
			"Source/Lumos/Platform/GLFW/*.cpp",

			"Source/Lumos/Platform/OpenAL/*.h",
			"Source/Lumos/Platform/OpenAL/*.cpp",

			"Source/Lumos/Platform/OpenGL/*.h",
			"Source/Lumos/Platform/OpenGL/*.cpp",

			"Source/Lumos/Platform/Vulkan/*.h",
			"Source/Lumos/Platform/Vulkan/*.cpp",

			"External/glad/src/glad_wgl.c"
		}

		links
		{
			"Dbghelp",
			"glfw"
		}

		buildoptions
		{
			"/bigobj"
		}

		filter 'files:External/**.cpp'
			flags  { 'NoPCH' }
		filter 'files:External/**.c'
			flags  { 'NoPCH' }

	filter "system:macosx"
		cppdialect "C++17"
		systemversion "11.0"

		files
		{
			"Source/Lumos/Platform/macOS/*.mm",
			"Source/Lumos/Platform/macOS/*.h",
			"Source/Lumos/Platform/macOS/*.cpp",

			"Source/Lumos/Platform/Unix/*.h",
			"Source/Lumos/Platform/Unix/*.cpp",

			"Source/Lumos/Platform/GLFW/*.h",
			"Source/Lumos/Platform/GLFW/*.cpp",

			"Source/Lumos/Platform/OpenAL/*.h",
			"Source/Lumos/Platform/OpenAL/*.cpp",

			"Source/Lumos/Platform/OpenGL/*.h",
			"Source/Lumos/Platform/OpenGL/*.cpp",

			"Source/Lumos/Platform/Vulkan/*.h",
			"Source/Lumos/Platform/Vulkan/*.cpp"
		}

		defines
		{
			"LUMOS_PLATFORM_MACOS",
			"LUMOS_PLATFORM_UNIX",
			"LUMOS_RENDER_API_OPENGL",
			"LUMOS_RENDER_API_VULKAN",
			"VK_USE_PLATFORM_METAL_EXT",
			"LUMOS_IMGUI",
			"LUMOS_OPENAL",
			"LUMOS_VOLK",
			"USE_VMA_ALLOCATOR"
		}

		links
		{
			"QuartzCore.framework",
			"Metal.framework",
			"Cocoa.framework",
        	"IOKit.framework",
        	"CoreFoundation.framework",
			"CoreVideo.framework",
			"OpenAL.framework",
			"SystemConfiguration.framework",
			"glfw"
		}

		libdirs
		{
			"../bin/**"
		}

		buildoptions
		{
			"-Wno-attributes",
			"-Wno-nullability-completeness",
			"-fdiagnostics-absolute-paths"
		}

		pchheader "../Lumos/Source/Precompiled.h"
		pchsource "../Lumos/Source/Precompiled.cpp"

		SetRecommendedXcodeSettings()

		filter 'files:External/**.cpp'
			flags  { 'NoPCH' }
		filter 'files:External/**.c'
			flags  { 'NoPCH' }
		filter 'files:Source/Lumos/**.m'
			flags  { 'NoPCH' }
		filter 'files:Source/Lumos/**.mm'
			flags  { 'NoPCH' }

	filter "system:ios"
		cppdialect "C++17"
		systemversion "latest"
		kind "StaticLib"

		defines
		{
			"LUMOS_PLATFORM_IOS",
			"LUMOS_PLATFORM_MOBILE",
			"LUMOS_PLATFORM_UNIX",
			"LUMOS_RENDER_API_VULKAN",
			"VK_USE_PLATFORM_IOS_MVK",
			"LUMOS_IMGUI",
			"USE_VMA_ALLOCATOR",
			"LUMOS_OPENAL"
		}

		files
		{
			"Source/Lumos/Platform/iOS/*.mm",
			"Source/Lumos/Platform/iOS/*.h",
			"Source/Lumos/Platform/iOS/*.cpp",

			"Source/Lumos/Platform/OpenAL/*.h",
			"Source/Lumos/Platform/OpenAL/*.cpp",

			"Source/Lumos/Platform/Unix/*.h",
			"Source/Lumos/Platform/Unix/*.cpp",

			"Source/Lumos/Platform/Vulkan/*.h",
			"Source/Lumos/Platform/Vulkan/*.cpp"
		}

		removefiles
		{
			"Source/Lumos/Platform/Unix/UnixFileSystem.cpp"
		}

		links
		{
			"QuartzCore.framework",
			"Metal.framework",
        	"IOKit.framework",
        	"CoreFoundation.framework",
			"CoreVideo.framework",
			"OpenAL.framework"
		}

		libdirs
		{
			"../bin/**"
		}

		buildoptions
		{
			"-Wno-attributes",
			"-Wno-nullability-completeness"
		}

		SetRecommendedXcodeSettings()

	filter "system:linux"
		cppdialect "C++17"
		systemversion "latest"

		defines
		{
			"LUMOS_PLATFORM_LINUX",
			"LUMOS_PLATFORM_UNIX",
			"LUMOS_RENDER_API_OPENGL",
			"LUMOS_RENDER_API_VULKAN",
			"VK_USE_PLATFORM_XCB_KHR",
			"LUMOS_IMGUI",
			"LUMOS_VOLK",
			"LUMOS_OPENAL"
		}

		files
		{
			"Source/Lumos/Platform/Unix/*.h",
			"Source/Lumos/Platform/Unix/*.cpp",

			"Source/Lumos/Platform/GLFW/*.h",
			"Source/Lumos/Platform/GLFW/*.cpp",

			"Source/Lumos/Platform/OpenAL/*.h",
			"Source/Lumos/Platform/OpenAL/*.cpp",

			"Source/Lumos/Platform/OpenGL/*.h",
			"Source/Lumos/Platform/OpenGL/*.cpp",

			"Source/Lumos/Platform/Vulkan/*.h",
			"Source/Lumos/Platform/Vulkan/*.cpp"
		}

		links
		{
			"glfw",
			"libopenal"
		}

		linkoptions{ "-Wl,-rpath=\\$$ORIGIN" }

		libdirs
		{
			"../bin/**",
			"External/OpenAL/libs/linux"
		}

		buildoptions
		{
			"-fpermissive",
			"-fPIC",
			"-Wignored-attributes",
			"-Wno-psabi"
		}

		links { "X11", "pthread"}

		pchheader "../Lumos/Source/Precompiled.h"
		pchsource "../Lumos/Source/Precompiled.cpp"

		filter 'files:External/**.cpp'
			flags  { 'NoPCH' }
		filter 'files:External/**.c'
			flags  { 'NoPCH' }
		filter 'files:Source/Lumos/**.c'
			flags  { 'NoPCH' }

		filter {'system:linux', 'architecture:x86_64'}
			buildoptions
			{
				"-msse4.1",
			}

	filter "configurations:Debug"
		defines { "LUMOS_DEBUG", "_DEBUG","TRACY_ENABLE","LUMOS_PROFILE","TRACY_ON_DEMAND"  }
		symbols "On"
		runtime "Debug"
		optimize "Off"

	filter "configurations:Release"
		defines { "LUMOS_RELEASE", "NDEBUG", "TRACY_ENABLE","LUMOS_PROFILE", "TRACY_ON_DEMAND"}
		optimize "Speed"
		symbols "On"
		runtime "Release"

	filter "configurations:Production"
		defines { "LUMOS_PRODUCTION", "NDEBUG" }
		symbols "Off"
		optimize "Full"
		runtime "Release"