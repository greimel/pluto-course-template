### A Pluto.jl notebook ###
# v0.19.8

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ ddb7022e-5404-4278-9069-97d9730f277e
using JSON3

# ╔═╡ 60d603c3-c1e7-4d49-820f-288d20de70f5
using HypertextLiteral: @htl

# ╔═╡ 6a3614fb-81bd-474d-85cf-06725846a6c0
using PlutoUI: TableOfContents, Button

# ╔═╡ b14f33ae-89a7-473b-ac9b-1db0208faca7
using PlutoSliderServer, Logging

# ╔═╡ d45c8768-87e2-4f3c-8763-089ec43f1733
using Pluto: Pluto, without_pluto_file_extension

# ╔═╡ c64ebd9b-66a3-4f6c-8f8b-36f6b9ce8f19
using PlutoHooks: @skip_as_script

# ╔═╡ fb914eec-bc9c-4dd4-b92e-f507c7d0b150
using PlutoLinks: @use_task

# ╔═╡ 6ee83d91-b1d1-4b1e-95ca-6874e44167da
using UUIDs

# ╔═╡ e2fc5eab-e333-4ff8-951b-89fdfe40eef8
using Chain

# ╔═╡ 004b0769-ee4a-4749-86eb-97a3c2322452
md"""
# Customization
"""

# ╔═╡ 95fd01d9-2555-4e5b-a044-eab02e2967bf
md"""
## Course
"""

# ╔═╡ 2bee2fc7-3322-457f-a835-028c80eaf059
TITLE = "A Great Course"

# ╔═╡ a0057e4c-0bcf-4970-8a2b-0412ad5af510
SUBTITLE = "Content and Code"

# ╔═╡ 4be56e57-fea0-4fbe-9659-44bed594b1b2
INSTITUTION = "University of Greatness"

# ╔═╡ c9f17f9f-766a-4137-92c5-f8173561a7bc
INSTITUTION_URL = "https://www.tinbergen.nl"

# ╔═╡ ab7186a4-2287-41da-a939-70f142bfeacd
TERM = "Spring 2022"

# ╔═╡ a31d893d-2cde-4228-a506-6af013fe1f3e
LOGO_FILE = "julia-logo.svg"

# ╔═╡ dbb5e02a-2485-4ada-98d1-cc24fd6fc418
md"""
Colors of the sidebar can be adjusted in the css file.
"""

# ╔═╡ 83130e69-9b67-44b5-ad32-500162abc0d2
md"""
## Website
"""

# ╔═╡ 5b7892c6-ca5c-4c3a-b5d8-0a6323ee2fa9
md"""
`PREPATH` is used to specify the base URLs; if your site should be
available at `https://username.github.io/YourPackage.jl/` then the pre-path should be `YourPackage.jl`. If your site is meant to be hosted on a specific URL such as `https://awesomepkg.org` then set `prepath` to an empty string. Finally, adjust this if you want the deployed page to be in a subfolder e.g.: `YourPackage.jl/web/`.
"""

# ╔═╡ 88e1e91d-0d48-42e0-b4ab-4866624fd745
begin
	PREPATH = "pluto-course-template"
	@skip_as_script PREPATH = ""
end

# ╔═╡ 2582ae89-616f-4a08-be81-0875362c1f7e
md"""
#### Add notebook header?
"""

# ╔═╡ c5e00f30-e734-4b59-97b9-8e5f59fd131e
add_notebook_header = true

# ╔═╡ 0b81d3ff-fa78-48c3-878c-24f9d6a34f20
show_section_number = false

# ╔═╡ 01a2336a-5c04-4d5a-bb0b-a9c704517dbf
pages = [
	(page = "/logistics/", title = "Class Logistics"),
	(page = "/syllabus/", title = "Syllabus"),
	(page = "/installation/", title = "Software installation"),
	(page = "/cheatsheets/", title = "Cheatsheets")
]

# ╔═╡ c0768146-5ea0-4736-94f8-2c1a2affa922
SLASH_PREPATH = !isempty(PREPATH) ? "/" * PREPATH : ""

# ╔═╡ 02e00e09-76a5-4f38-8557-4d9caf280b4c
homepage = (page = "/index.html", path = "$SLASH_PREPATH/", title = "Welcome")

# ╔═╡ d83ee9b9-d255-4217-a776-3b0f4f168c8f
@bind regenerate Button("Regenerate!")

# ╔═╡ 41b00a73-f42d-4e9e-86bb-49ff9105d949
const WEBSITE_DIR = let
	regenerate
	@__DIR__
end

# ╔═╡ e8169711-6e94-45e0-9c41-b4d4692af328
const PROJECT_ROOT = let
	regenerate
	joinpath(@__DIR__, "..") |> normpath
end

# ╔═╡ 8781d8d4-0dff-4b24-9500-6ba4ec586f9b
pluto_cache_dir = mkpath(joinpath(PROJECT_ROOT, "pluto_state_cache"))

# ╔═╡ 6eb94b8c-b972-4c80-9644-1bd6568dc943
output_dir = let
	PROJECT_ROOT
	joinpath(PROJECT_ROOT, "build")
end

# ╔═╡ 149b7852-ae23-447a-80bb-24cdd7993cfe
pluto_notebooks_output_dir = mkpath(joinpath(output_dir, "notebooks"))

# ╔═╡ 68bff1d9-8fe4-4b88-82a2-49bbf6209019
import StructTypes

# ╔═╡ 0abe998c-f69c-49de-a49f-6c4bbcb6c4e1
begin
	Base.@kwdef struct Section
	    name::String
	    notebook_path::String
	    video_id::String
	    preview_image_url::String
	end
		StructTypes.StructType(::Type{Section}) = StructTypes.Struct()
	
end

# ╔═╡ 0fbcf5d1-b342-427c-a09d-e2f84725ba7f
begin
Base.@kwdef struct Chapter
	title::String
	contents::Vector{Section}=Section[]
end
	StructTypes.StructType(::Type{Chapter}) = StructTypes.Struct()
end

# ╔═╡ 43969dd1-f175-4399-8758-5a69f94595e7
book_model = JSON3.read(read("./book_model.json", String), Vector{Chapter})

# ╔═╡ ec4ac489-8b49-4c2d-be87-21bb3f70e06a
md"""
# Running a file server for dev
"""

# ╔═╡ 680b5653-a0a0-48ad-87ca-583a1655a05c
import Deno_jll

# ╔═╡ c012ae32-3b48-460c-8b1a-0b3e06f5fda0
file_server_port = 4599

# ╔═╡ 06bfaeee-a6ee-439c-b965-94d0455b0337
file_server_address(paths::AbstractString...) = join([
	"http://localhost:$(file_server_port)",
	paths...
], "/")

# ╔═╡ 35b80456-039e-45bc-963e-5466a3e9c3a7
@skip_as_script @use_task([]) do 
	sleep(1)
	error("asdf")
end

# ╔═╡ a24bf899-87b0-4a2e-a6d4-30ac2aad4820
md"""
# Static assets
"""

# ╔═╡ 2bba13d3-0c1d-4d17-bd70-526ce70407fb
md"""
# Sidebar
"""

# ╔═╡ feaed8af-05d0-4b80-9f69-8f827f9343a8
bold(text) = @htl("<b>$(text)</b>")

# ╔═╡ 4a7a342d-4bf2-455d-9cf9-52a827e180d4
emph(text) = @htl("<em>$(text)</em>")

# ╔═╡ b5b07aac-1681-46ac-a234-198ba8261882
href(path, text) = @htl("<a href=$(path)>$(text)</a>")

# ╔═╡ fd5f6637-3223-4f0b-94a6-ace86f5a5926
function instructors(INSTRUCTORS)
	tmp = map(INSTRUCTORS) do (; name, url)
		href(url, name)
	end
	join(tmp, ", ", "&amp " ) |> HTML
end

# ╔═╡ 3e93e57c-3660-416f-9874-d43abf99e60e
INSTRUCTORS = [
	(name = "Person 1", url = ""),
	(name = "Person 2", url = "")
] |> instructors

# ╔═╡ d78c58e5-3ecb-45ee-972e-20fc90ece3cc
path_to_asset(file) = joinpath(SLASH_PREPATH, "assets", file)

# ╔═╡ f4d1018b-8f25-4478-91b8-ea55e66fe542
joinpath(@__DIR__(), path_to_asset(LOGO_FILE)) |> isfile

# ╔═╡ 98fb1e6a-c57c-4d66-972f-3471c6c15dd7
function sidebar_page(; page, title, path="$(SLASH_PREPATH)$(page)", isbold = false)
	title = isbold ? bold(title) : title
	@htl("""
	<a class="sidebar-nav-item {{ispage $(page)}}active{{end}}" href="$(path)">$(title)</a>
	""")
end

# ╔═╡ 6775885d-0340-462e-bdeb-1e9076d94925
function sidebar_pages(pages)
	vec = map(pages) do page
		sidebar_page(; page...)
	end
	HTML(join(vec, "\n"))
end

# ╔═╡ 4489fbec-39b9-454f-ad17-3a1101d335ce
md"""
# Title headers inside notebooks
"""

# ╔═╡ 8eac52e6-6a5e-4519-9b4c-80aadbf27573
function flatten_path(input::String)
	join(input |> splitpath, "_")
end

# ╔═╡ 444502c9-33b5-4bb2-9a8d-a8d8e1adb632
function sidebar_code(book_model)
    @htl("""
    <div class="sidebar">
    <div class="container sidebar-sticky">
    <div class="sidebar-about">
    <br>
    <img src="$(path_to_asset(LOGO_FILE))" style="margin-left:1em; width: 80px; height: auto; display: inline">
    <div style="font-weight: bold; margin-bottom: 0.5em">
	$(href("$(SLASH_PREPATH)/semesters/", TERM))
	<span style="opacity: 0.6;">|
	$(href(INSTITUTION_URL,INSTITUTION))
	</span>
	</div>
    <h1>$(href("$(SLASH_PREPATH)/",TITLE))</h1>
    <h2>$(SUBTITLE)</h2>
    <div style="line-height:18px; font-size: 15px; opacity: 0.85">by $(INSTRUCTORS)</div>
    </div>
    <br>
    <style>
    </style>
    <nav class="sidebar-nav" style="opacity: 0.9">
	$(sidebar_page(; homepage..., isbold = true))
	$(sidebar_pages(pages))
    <br>
    $(map(enumerate(book_model)) do (chapter_number, chap)
		@htl("""
		<div class="course-section">Module $(chapter_number): $(chap.title)</div>
		
		$(map(enumerate(chap.contents)) do (section_number, section)

			notebook_name = 
				basename(without_pluto_file_extension(section.notebook_path))
			notebook_id = flatten_path(without_pluto_file_extension(section.notebook_path))
			
		    @htl("""
		    <a class="sidebar-nav-item {{ispage /$notebook_name/}}active{{end}}" href="$(SLASH_PREPATH)/$notebook_id/"><b>$(chapter_number).$(section_number)</b> - <em>$(section.name)</em></a>
		    """)
		end)
		""")
	end)

    <br>
    </nav>
    </div>
    </div>
	""")
end

# ╔═╡ 544518ea-d36d-4e80-855e-93895a8cc35d
sidebar = sidebar_code(book_model)

# ╔═╡ 32540d48-becf-482a-990c-4cd4d13d93f3
function output_notebook_relpath(input::String)
	joinpath(pluto_notebooks_output_dir , flatten_path(input))
end

# ╔═╡ a8ae5287-e7b6-4b68-ac26-4bc55ee86fe6
output_notebook_relpath(s::Section) = output_notebook_relpath(s.notebook_path)

# ╔═╡ 5ec6013c-da21-4cdb-b43f-16d997bc8446
import Random

# ╔═╡ bb5bca01-8f95-49a5-8e50-2ad013c6b804
@skip_as_script run(`open $(pluto_notebooks_output_dir)`)

# ╔═╡ 9979265f-60dd-42d4-9384-afaf4bf53ba2
md"""Show header preview: $(@bind show_header_preview html"<input type=checkbox>")"""

# ╔═╡ cebba3d4-f255-4039-bba4-0673ac4e700b
function embed_youtube(video_id, title = "Lecture Video")
	if video_id == ""
		return ""
	else
		return @htl(
			"""
		 	<p style="
		    font-size: 1.5rem;
		    text-align: center;
		    opacity: .8;
		    ">$(emph(title))</p>
		    <div style="display: flex; justify-content: center;">
		    <div  notthestyle="position: relative; right: 0; top: 0; z-index: 300;">
		    <iframe src="https://www.youtube.com/embed/$(video_id)" width=400 height=250  frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe></div>
			</div>
			
		    </div>
			"""
		)
	end
end

# ╔═╡ 2087dbd4-ea11-450f-92e3-4c24f3fa8f76
function format_section_number(chapter_number, section_number)
	@htl(
		"""
		<p style="
    	font-size: 1.5rem;
    	opacity: .8;
    	">$(emph("Section $(chapter_number).$(section_number)"))</p>
		"""	
	)
end	

# ╔═╡ b007e5cc-d7c3-4275-86fd-9098bc398b23
function notebook_header(section::Section, chapter_number::Integer, section_number::Integer; show_section_number=true)
	has_video = section.video_id != ""
	height = 180
	if has_video
		height = height + 250
	end
	if show_section_number
		height = height + 70
	end
    @htl("""
    <div style="
    position: absolute;
    width: calc(100% - 30px);
    border: 50vw solid #282936;
    border-top: 500px solid #282936;
    border-bottom: none;
    box-sizing: content-box;
    left: calc(-50vw + 15px);
    top: -500px;
    height: $(height)px;
    pointer-events: none;
    "></div>

    <div style="
    height: $(height)px;
    width: 100%;
    background: #282936;
    color: #fff;
    padding-top: 68px;
    ">
    <span style="
    font-family: Vollkorn, serif;
    font-weight: 700;
    font-feature-settings: 'lnum', 'pnum';
    "> 
	$(show_section_number ? format_section_number(chapter_number, section_number) : "")
    <p style="text-align: center; font-size: 2rem;">
    $(emph(section.name))
    </p>

	$(embed_youtube(section.video_id))
	
    <style>
    body {
    overflow-x: hidden;
    }
    </style>""")
end

# ╔═╡ 48570953-88d3-4010-a5e3-2034bda26413
if show_header_preview === true
	notebook_header(book_model[2].contents[1], 1, 1; show_section_number=true)
end

# ╔═╡ 5f93b932-6739-4b7e-bfdb-1bc1f7d57e65
notebook_header_code(args...; kwargs...) = "HTML($(repr(string(notebook_header(args...; kwargs...)))))"

# ╔═╡ 96aa002c-cebc-41f7-97cf-ecd02081b6ce
md"""
# Generate HTML notebook exports
(using PlutoSliderServer)
"""

# ╔═╡ d15f2d13-0885-4da2-950d-fbbdd83f3907
md"""
# Generate non-Pluto pages from markdown, add sidebar

_powered by Franklin.jl_
"""

# ╔═╡ 9cb9559a-cbe4-4a4a-b974-cb9a3573f67d
import Franklin

# ╔═╡ 0e1a2d5b-16da-49e9-98b3-6f1202fd0fa1
begin
	current_dir = pwd()
	website_dir = joinpath(PROJECT_ROOT, "website")
end

# ╔═╡ afff6777-1fec-41ee-bbba-b99dab0fd008
function franklin_config()
	franklin_config_file_base = joinpath(WEBSITE_DIR, "franklin-config.md")
	franklin_config_file = joinpath(website_dir, "config.md")
	
	cp(franklin_config_file_base, franklin_config_file, force=true)

	isfile(franklin_config_file)

	open(franklin_config_file, "a") do f

		write(f, 
			"""
			
			@def title = "$TITLE"
			@def prepath = "$PREPATH"
			@def description = "$TITLE - $SUBTITLE"
			@def authors = ""
			"""
		)
		flush(f)
	end
end

# ╔═╡ fbfcd2b0-3fb0-4999-ba59-4706437a501e
begin
	franklin_page_dir = joinpath(website_dir, "__site")
	if isdir(franklin_page_dir)
		rm(franklin_page_dir, recursive = true)
		#@info "removed" franklin_page_dir
	end
	mkpath(franklin_page_dir)
	franklin_config()
	cd(website_dir)
	Logging.with_logger(Logging.NullLogger()) do
		Franklin.optimize(; minify = false)
	end
	#cp(joinpath(website_dir, "__site"), franklin_page_dir, force = true)
	cd(current_dir)
end

# ╔═╡ a965eb6b-8c70-4986-a7b1-99c820c45716
@skip_as_script @use_task([franklin_page_dir, file_server_port]) do

	run(`$(Deno_jll.deno()) run --allow-net --allow-read https://deno.land/std@0.115.0/http/file_server.ts $(franklin_page_dir) --cors --port $(file_server_port)`)

end

# ╔═╡ 5c69b7bd-6b18-496f-bcd5-3251a5eb0dd8
franklin_pages = @chain begin
	franklin_page_dir
	readdir(join = true)
	filter(isdir, _)
	filter(x -> basename(x) != "css", _)
	[_; franklin_page_dir]
end

# ╔═╡ 77617779-76f0-4dec-aeea-cda321c71c9e
md"""
# Move to joint directory
"""

# ╔═╡ 190e776a-600e-41a4-b4de-08884036d610
output_dir

# ╔═╡ e49944c7-e975-4018-b068-90b872b6d175
franklin_page_dir

# ╔═╡ 7ec64792-82d4-454d-83ce-d507d66e80e7
md"""
# Generate `index.html` files for notebooks
"""

# ╔═╡ 729efdbc-9556-4d34-bcef-1dfff2fba6bb
function index_html_filename(section::Section)
	new_jl_name = flatten_path(section.notebook_path)
	new_dir_name = without_pluto_file_extension(new_jl_name)
	dir_name = mkpath(joinpath(output_dir, new_dir_name))
	joinpath(dir_name, "index.html")
end

# ╔═╡ c0d7eb1c-7b6f-446f-ab50-7d7a49a5b1b1
iframe(src::AbstractString; style=nothing) = @htl("""
<iframe width="100%" height="100%" src=$(src) style=$(style) class="plutopage" frameborder="0" allow="accelerometer; ambient-light-sensor; autoplay; battery; camera; display-capture; document-domain; encrypted-media; execution-while-not-rendered; execution-while-out-of-viewport; fullscreen; geolocation; gyroscope; layout-animations; legacy-image-formats; magnetometer; microphone; midi; navigation-override; oversized-images; payment; picture-in-picture; publickey-credentials-get; sync-xhr; usb; wake-lock; screen-wake-lock; vr; web-share; xr-spatial-tracking" allowfullscreen></iframe>
""")

# ╔═╡ 140990ab-0a8c-4000-b17d-30e2f33dfd5f
web_preview(args...) = let
	href = file_server_address(args...)
	@htl("""
	<div style='font-family: system-ui; margin: .5em;'>Showing preview of <a href=$(href) target="_blank">$href</a></div>
	<div style="border: 10px solid pink; border-radius: 10px; padding: 0px">
	$(iframe(href; style=Dict("min-height"=> "60vh")))
</div>
	""")
end

# ╔═╡ 9b12c862-3604-4046-8d68-89dd2d198883
@skip_as_script web_preview()

# ╔═╡ e6e791d7-0f29-404a-8bdf-0c5f25d48da7
index_styles(root_dir=".") = @htl("""
<link rel="stylesheet" href="$(root_dir)/css/franklin.css">
    <link rel="stylesheet" href="$(root_dir)/css/poole_hyde.css">
    <link rel="stylesheet" href="$(root_dir)/css/custom.css">
    <!-- style adjustments -->
    <style>
        html {
            font-size: 17px;
        }

        .franklin-content {
            position: relative;
            padding-left: 8%;
            padding-right: 5%;
            line-height: 1.35em;
        }

        @media (min-width: 940px) {
            .franklin-content {
                width: 100%;
                margin-left: auto;
                margin-right: auto;
            }
        }

        @media (max-width: 768px) {
            .franklin-content {
                padding-left: 6%;
                padding-right: 6%;
            }
        }
    </style>
	""");

# ╔═╡ 2234f31d-89f3-4e58-8d89-e7ae9aa5b2db
index_footer = "" #= @htl("""
<!-- Global site tag (gtag.js) - Google Analytics -->
    <script async src="https://www.googletagmanager.com/gtag/js?id=UA-28835595-11"></script>
    <script>
      window.dataLayer = window.dataLayer || [];
      function gtag(){dataLayer.push(arguments);}
      gtag('js', new Date());
      gtag('config', 'UA-28835595-11');
    </script>
	""") =#;

# ╔═╡ 669ca7b1-9433-4391-b849-2f1cc7f4aa49
function html_page(content, root_dir::String=".")
	@htl("""
	<html lang="en">
	
	<head>
	    <meta charset="UTF-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1">
	
	    $(index_styles(root_dir))
	    <link rel="icon" href="$(root_dir)/assets/favicon.png">
	
	    <title>$TITLE</title>
	</head>
	
	<body>
	    $(sidebar)
	    <div class="content container">
	
	        <!-- Content appended here -->
	        <div class="franklin-content">
				$(content)
	
	        </div><!-- CONTENT ENDS HERE -->
	
	    </div> <!-- div: content container -->
	
	    $(index_footer)
	</body>
	
	</html>
	""")
	
end

# ╔═╡ 29a3e3f4-1c7a-44e4-89c2-ce12d31f4fd7
notebook_index_styles = @htl("""
<style>

.content {
    max-width: 100%;
    margin-right: 0px;
    padding: 0px;
    overflow-y: hidden;
    height: 100vh;
}
.franklin-content {
    padding: 0px;
}
.page-foot {
    display: none;
}
.plutopage {
    height: 100vh;
}
.smallscreenlink {
    display: none;
}
@media (max-width: 768px) {
    .franklin-content {
        padding: 0px;
    }
}
</style>
""");

# ╔═╡ 35d20fb6-be54-4d6c-b6aa-5bc2529dafea
function add_sidebar(page_dir)
	page_name = basename(page_dir)
	rel_page_dir = page_name == "__site" ? "." : joinpath("..", page_name)
	index_page = joinpath(rel_page_dir, "main.html")
	new_page_dir = page_dir # joinpath(output_dir, page_name)
	isdir(new_page_dir) || mkpath(new_page_dir)

	
	@chain index_page begin
		iframe
		html_page(@htl("""
		$(notebook_index_styles)

		$(_)"""), SLASH_PREPATH)
		string
		"<!doctype html>\n" * _
		write(joinpath(new_page_dir, "index.html")	, _)
	end
end

# ╔═╡ d276b28e-a379-4804-ad25-f7d396b4ffb6
for page_dir in franklin_pages
	mv(joinpath(page_dir, "index.html"), joinpath(page_dir, "main.html"), force=true)
	add_sidebar(page_dir)
end; FRANKLIN_DONE = 1

# ╔═╡ 1780b6d1-5e53-48e0-8675-f78645e7c576
function notebook_html_page(section)
	new_jl_name = flatten_path(section.notebook_path)
	new_jl_relpath = "notebooks/$(new_jl_name)"
	new_html_relpath = without_pluto_file_extension(new_jl_relpath) * ".html"
	
	html_page(
		@htl("""
		$(notebook_index_styles)
	
		$(iframe("../$(new_html_relpath)"))
		"""),
		".."
	)
end

# ╔═╡ 4d78b60b-7311-4735-892b-1719729611d7
md"""
# Appendix
"""

# ╔═╡ 276ef05c-25b3-4450-9dfc-9bdd9525c00c
flatmap(args...) = vcat(map(args...)...)

# ╔═╡ d7098dc2-fe08-4545-921c-6ad3d2648c91
static_assets = let
	flatmap(readdir(WEBSITE_DIR)) do f
		path_abs = joinpath(WEBSITE_DIR, f)
		if isdir(path_abs)
			cp(path_abs, joinpath(output_dir, f); force=true)
			[f]
		else
			[]
		end
	end
end

# ╔═╡ adc183d3-2615-4334-88f0-2f8f0876b4b7
output_filenames = flatmap(enumerate(book_model)) do (chapter_number, chap)
	
	map(enumerate(chap.contents)) do (section_number, section)
		new_path = output_notebook_relpath(section)

		# read original notebook
		notebook = Pluto.load_notebook_nobackup(joinpath(PROJECT_ROOT, section.notebook_path))
		notebook.path = new_path

		# generate UUIDs deterministically to avoid changing the notebook hash 
		my_rng = Random.MersenneTwister(123)

		# generate code for the header
		header_code = add_notebook_header ? notebook_header_code(section, chapter_number, section_number; show_section_number) : ""
		first_cell = Pluto.Cell(
			code = header_code,
			code_folded = true,
			cell_id=uuid4(my_rng)
		)

		# insert into the notebook
		notebook.cells_dict[first_cell.cell_id] = first_cell
		pushfirst!(notebook.cell_order, first_cell.cell_id)

		# save to file
		Pluto.save_notebook(notebook)

		new_path
	end
end

# ╔═╡ 866746a1-8102-431c-94e5-f93f6c98e825
notebook_htmls_generated = let
	output_filenames
	
	Logging.with_logger(Logging.NullLogger()) do
		PlutoSliderServer.export_directory(pluto_notebooks_output_dir; Export_cache_dir=pluto_cache_dir)
	end
end; GENERATED_NOTEBOOKS = 0

# ╔═╡ ccdea15d-1182-4d96-a7ab-26aa59a6002e
notebook_index_filenames = flatmap(enumerate(book_model)) do (chapter_number, chap)
	
	map(enumerate(chap.contents)) do (section_number, section)
		new_html_path = index_html_filename(section)

		static_assets

		write(new_html_path, "<!doctype html>\n" * string(notebook_html_page(section)))
		new_html_path	
	end
end; PLUTO_DONE = GENERATED_NOTEBOOKS + 1

# ╔═╡ db665156-3a33-4c33-a979-74ef2c9f5792
let
	PLUTO_DONE
	FRANKLIN_DONE

	folders = filter(startswith(r"note|assets"), readdir(output_dir))
	for folder in folders
		cp(joinpath(output_dir, folder), joinpath(franklin_page_dir, folder), force=true)
	end
end

# ╔═╡ 811bffb7-1041-4f96-b2e6-f24ddce8d753
let
	notebook_index_filenames
	@skip_as_script relpath(index_html_filename(book_model[1].contents[1]), output_dir) |> web_preview
end

# ╔═╡ 291dec1b-a998-4c56-b06f-008cd3a6ccd7
TableOfContents()

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Chain = "8be319e6-bccf-4806-a6f7-6fae938471bc"
Deno_jll = "04572ae6-984a-583e-9378-9577a1c2574d"
Franklin = "713c75ef-9fc9-4b05-94a9-213340da978e"
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
JSON3 = "0f8b85d8-7281-11e9-16c2-39a750bddbf1"
Logging = "56ddb016-857b-54e1-b83d-db4d58db5568"
Pluto = "c3e4b0f8-55cb-11ea-2926-15256bba5781"
PlutoHooks = "0ff47ea0-7a50-410d-8455-4348d5de0774"
PlutoLinks = "0ff47ea0-7a50-410d-8455-4348d5de0420"
PlutoSliderServer = "2fc8631c-6f24-4c5b-bca7-cbb509c42db4"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Random = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
StructTypes = "856f2bd8-1eba-4b0a-8007-ebc267875bd4"
UUIDs = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[compat]
Chain = "~0.5.0"
Deno_jll = "~1.20.4"
Franklin = "~0.10.75"
HypertextLiteral = "~0.9.4"
JSON3 = "~1.9.5"
Pluto = "~0.19.9"
PlutoHooks = "~0.0.5"
PlutoLinks = "~0.1.5"
PlutoSliderServer = "~0.3.11"
PlutoUI = "~0.7.39"
StructTypes = "~1.8.1"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

manifest_format = "2.0"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "8eaf9f1b4921132a4cff3f36a1d9ba923b14a481"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.1.4"

[[deps.AbstractTrees]]
git-tree-sha1 = "03e0550477d86222521d254b741d470ba17ea0b5"
uuid = "1520ce14-60c1-5f80-bbc7-55ef81b5835c"
version = "0.3.4"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.BetterFileWatching]]
deps = ["Deno_jll", "JSON"]
git-tree-sha1 = "0d7ee0a1acad90d544fa87cc3d6f463e99abb77a"
uuid = "c9fd44ac-77b5-486c-9482-9798bd063cc6"
version = "0.1.5"

[[deps.Chain]]
git-tree-sha1 = "8c4920235f6c561e401dfe569beb8b924adad003"
uuid = "8be319e6-bccf-4806-a6f7-6fae938471bc"
version = "0.5.0"

[[deps.CodeTracking]]
deps = ["InteractiveUtils", "UUIDs"]
git-tree-sha1 = "6d4fa04343a7fc9f9cb9cff9558929f3d2752717"
uuid = "da1fd8a2-8d9e-5ec2-8556-3022fb5608a2"
version = "1.0.9"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"

[[deps.Configurations]]
deps = ["ExproniconLite", "OrderedCollections", "TOML"]
git-tree-sha1 = "79e812c535bb9780ba00f3acba526bde5652eb13"
uuid = "5218b696-f38b-4ac9-8b61-a12ec717816d"
version = "0.16.6"

[[deps.Crayons]]
git-tree-sha1 = "249fe38abf76d48563e2f4556bebd215aa317e15"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.1.1"

[[deps.DataAPI]]
git-tree-sha1 = "fb5f5316dd3fd4c5e7c30a24d50643b73e37cd40"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.10.0"

[[deps.DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"

[[deps.Deno_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "970da1e64a94f13b51c81691c376a1d5a83a0b3c"
uuid = "04572ae6-984a-583e-9378-9577a1c2574d"
version = "1.20.4+0"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "b19534d1895d702889b219c382a6e18010797f0b"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.8.6"

[[deps.Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "bad72f730e9e91c08d9427d5e8db95478a3c323d"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.4.8+0"

[[deps.ExprTools]]
git-tree-sha1 = "56559bbef6ca5ea0c0818fa5c90320398a6fbf8d"
uuid = "e2ba6199-217a-4e67-a87a-7c52f15ade04"
version = "0.1.8"

[[deps.ExproniconLite]]
git-tree-sha1 = "8b08cc88844e4d01db5a2405a08e9178e19e479e"
uuid = "55351af7-c7e9-48d6-89ff-24e801d99491"
version = "0.6.13"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Franklin]]
deps = ["Dates", "DelimitedFiles", "DocStringExtensions", "ExprTools", "FranklinTemplates", "HTTP", "Literate", "LiveServer", "Logging", "Markdown", "NodeJS", "OrderedCollections", "Pkg", "REPL", "Random", "TOML"]
git-tree-sha1 = "80fe9a242a5124ef47ff769105578efed3d50379"
uuid = "713c75ef-9fc9-4b05-94a9-213340da978e"
version = "0.10.75"

[[deps.FranklinTemplates]]
deps = ["LiveServer"]
git-tree-sha1 = "d15c3043dc90d5df4e499f66a2e3a9c676a41240"
uuid = "3a985190-f512-4703-8d38-2a7944ed5916"
version = "0.8.28"

[[deps.FromFile]]
deps = ["Downloads", "Requires"]
git-tree-sha1 = "5df4ca248bed8c35164d6a7ae006073bbf8289ff"
uuid = "ff7dd447-1dcb-4ce3-b8ac-22a812192de7"
version = "0.1.5"

[[deps.FuzzyCompletions]]
deps = ["REPL"]
git-tree-sha1 = "efd6c064e15e92fcce436977c825d2117bf8ce76"
uuid = "fb4132e2-a121-4a70-b8a1-d5b831dcdcc2"
version = "0.5.0"

[[deps.Gettext_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "9b02998aba7bf074d14de89f9d37ca24a1a0b046"
uuid = "78b55507-aeef-58d4-861c-77aaff3498b1"
version = "0.21.0+0"

[[deps.Git]]
deps = ["Git_jll"]
git-tree-sha1 = "d7bffc3fe097e9589145493c08c41297b457e5d0"
uuid = "d7ba0133-e1db-5d97-8f8c-041e4b3a1eb2"
version = "1.2.1"

[[deps.GitHubActions]]
deps = ["JSON", "Logging"]
git-tree-sha1 = "56e01ec63d13e1cf015d9ff586156eae3cc7cd6f"
uuid = "6b79fd1a-b13a-48ab-b6b0-aaee1fee41df"
version = "0.1.4"

[[deps.Git_jll]]
deps = ["Artifacts", "Expat_jll", "Gettext_jll", "JLLWrappers", "LibCURL_jll", "Libdl", "Libiconv_jll", "OpenSSL_jll", "PCRE2_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "6e93d42b97978709e9c941fa43d0f01701f0d290"
uuid = "f8c6e375-362e-5223-8a59-34ff63f689eb"
version = "2.34.1+0"

[[deps.HTTP]]
deps = ["Base64", "Dates", "IniFile", "Logging", "MbedTLS", "NetworkOptions", "Sockets", "URIs"]
git-tree-sha1 = "0fa77022fe4b511826b39c894c90daf5fce3334a"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "0.9.17"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "8d511d5b81240fc8e6802386302675bdf47737b9"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.4"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "c47c5fa4c5308f27ccaac35504858d8914e102f9"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.4"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "f7be53659ab06ddc986428d3a9dcc95f6fa6705a"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.2"

[[deps.IniFile]]
git-tree-sha1 = "f550e6e32074c939295eb5ea6de31849ac2c9625"
uuid = "83e8ac13-25f8-5344-8a64-a9f2b223428f"
version = "0.5.1"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[deps.JLLWrappers]]
deps = ["Preferences"]
git-tree-sha1 = "abc9885a7ca2052a736a600f7fa66209f96506e1"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.4.1"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "3c837543ddb02250ef42f4738347454f95079d4e"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.3"

[[deps.JSON3]]
deps = ["Dates", "Mmap", "Parsers", "StructTypes", "UUIDs"]
git-tree-sha1 = "fd6f0cae36f42525567108a42c1c674af2ac620d"
uuid = "0f8b85d8-7281-11e9-16c2-39a750bddbf1"
version = "1.9.5"

[[deps.JuliaInterpreter]]
deps = ["CodeTracking", "InteractiveUtils", "Random", "UUIDs"]
git-tree-sha1 = "52617c41d2761cc05ed81fe779804d3b7f14fff7"
uuid = "aa1ae85d-cabe-5617-a682-6adf51b2e16a"
version = "0.9.13"

[[deps.LeftChildRightSiblingTrees]]
deps = ["AbstractTrees"]
git-tree-sha1 = "b864cb409e8e445688bc478ef87c0afe4f6d1f8d"
uuid = "1d6d02ad-be62-4b6b-8a6d-2f90e265016e"
version = "0.1.3"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"

[[deps.LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "42b62845d70a619f063a7da093d995ec8e15e778"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.16.1+1"

[[deps.LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.Literate]]
deps = ["Base64", "IOCapture", "JSON", "REPL"]
git-tree-sha1 = "5b5ec7696d40868945c407f28a6672a230448b70"
uuid = "98b081ad-f1c9-55d3-8b20-4c87d4299306"
version = "2.13.4"

[[deps.LiveServer]]
deps = ["Crayons", "FileWatching", "HTTP", "Pkg", "Sockets", "Test"]
git-tree-sha1 = "707f77cd832ed02fddcf5b914dbab70cbf0e463b"
uuid = "16fef848-5104-11e9-1b77-fb7a48bbb589"
version = "0.7.4"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.LoweredCodeUtils]]
deps = ["JuliaInterpreter"]
git-tree-sha1 = "dedbebe234e06e1ddad435f5c6f4b85cd8ce55f7"
uuid = "6f1432cf-f94c-5a45-995e-cdbf5db27b0b"
version = "2.2.2"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "Random", "Sockets"]
git-tree-sha1 = "1c38e51c3d08ef2278062ebceade0e46cefc96fe"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.0.3"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[deps.MsgPack]]
deps = ["Serialization"]
git-tree-sha1 = "a8cbf066b54d793b9a48c5daa5d586cf2b5bd43d"
uuid = "99f44e22-a591-53d1-9472-aa23ef4bd671"
version = "1.1.0"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[deps.NodeJS]]
deps = ["Pkg"]
git-tree-sha1 = "905224bbdd4b555c69bb964514cfa387616f0d3a"
uuid = "2bd173c7-0d6d-553b-b6af-13a54713934c"
version = "1.3.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "9a36165cf84cff35851809a40a928e1103702013"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "1.1.16+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "85f8e6578bf1f9ee0d11e7bb1b1456435479d47c"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.4.1"

[[deps.PCRE2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "efcefdf7-47ab-520b-bdef-62a2eaa19f15"

[[deps.Parsers]]
deps = ["Dates"]
git-tree-sha1 = "0044b23da09b5608b4ecacb4e5e6c6332f833a7e"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.3.2"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[deps.Pluto]]
deps = ["Base64", "Configurations", "Dates", "Distributed", "FileWatching", "FuzzyCompletions", "HTTP", "HypertextLiteral", "InteractiveUtils", "Logging", "MIMEs", "Markdown", "MsgPack", "Pkg", "PrecompileSignatures", "REPL", "RelocatableFolders", "Sockets", "TOML", "Tables", "URIs", "UUIDs"]
git-tree-sha1 = "87b0f17b2a71eb4a20b61eed34975055fe5537dd"
uuid = "c3e4b0f8-55cb-11ea-2926-15256bba5781"
version = "0.19.9"

[[deps.PlutoHooks]]
deps = ["InteractiveUtils", "Markdown", "UUIDs"]
git-tree-sha1 = "072cdf20c9b0507fdd977d7d246d90030609674b"
uuid = "0ff47ea0-7a50-410d-8455-4348d5de0774"
version = "0.0.5"

[[deps.PlutoLinks]]
deps = ["FileWatching", "InteractiveUtils", "Markdown", "PlutoHooks", "Revise", "UUIDs"]
git-tree-sha1 = "0e8bcc235ec8367a8e9648d48325ff00e4b0a545"
uuid = "0ff47ea0-7a50-410d-8455-4348d5de0420"
version = "0.1.5"

[[deps.PlutoSliderServer]]
deps = ["AbstractPlutoDingetjes", "Base64", "BetterFileWatching", "Configurations", "Distributed", "FromFile", "Git", "GitHubActions", "HTTP", "JSON", "Logging", "Pkg", "Pluto", "SHA", "Sockets", "TOML", "TerminalLoggers", "UUIDs"]
git-tree-sha1 = "5496bc77ee81a91187dc3b9de3a32a631c562575"
uuid = "2fc8631c-6f24-4c5b-bca7-cbb509c42db4"
version = "0.3.11"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "UUIDs"]
git-tree-sha1 = "8d1f54886b9037091edf146b517989fc4a09efec"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.39"

[[deps.PrecompileSignatures]]
git-tree-sha1 = "18ef344185f25ee9d51d80e179f8dad33dc48eb1"
uuid = "91cefc8d-f054-46dc-8f8c-26e11d7c5411"
version = "3.0.3"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "47e5f437cc0e7ef2ce8406ce1e7e24d44915f88d"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.3.0"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.ProgressLogging]]
deps = ["Logging", "SHA", "UUIDs"]
git-tree-sha1 = "80d919dee55b9c50e8d9e2da5eeafff3fe58b539"
uuid = "33c8b6b6-d38a-422a-b730-caa89a2f386c"
version = "0.1.4"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.RelocatableFolders]]
deps = ["SHA", "Scratch"]
git-tree-sha1 = "22c5201127d7b243b9ee1de3b43c408879dff60f"
uuid = "05181044-ff0b-4ac5-8273-598c1e38db00"
version = "0.3.0"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.Revise]]
deps = ["CodeTracking", "Distributed", "FileWatching", "JuliaInterpreter", "LibGit2", "LoweredCodeUtils", "OrderedCollections", "Pkg", "REPL", "Requires", "UUIDs", "Unicode"]
git-tree-sha1 = "4d4239e93531ac3e7ca7e339f15978d0b5149d03"
uuid = "295af30f-e4ad-537b-8983-00126c2a3abe"
version = "3.3.3"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "0b4b7f1393cff97c33891da2a0bf69c6ed241fda"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.1.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.StructTypes]]
deps = ["Dates", "UUIDs"]
git-tree-sha1 = "d24a825a95a6d98c385001212dc9020d609f2d4f"
uuid = "856f2bd8-1eba-4b0a-8007-ebc267875bd4"
version = "1.8.1"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[[deps.TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[deps.Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "LinearAlgebra", "OrderedCollections", "TableTraits", "Test"]
git-tree-sha1 = "5ce79ce186cc678bbb5c5681ca3379d1ddae11a1"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.7.0"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"

[[deps.TerminalLoggers]]
deps = ["LeftChildRightSiblingTrees", "Logging", "Markdown", "Printf", "ProgressLogging", "UUIDs"]
git-tree-sha1 = "62846a48a6cd70e63aa29944b8c4ef704360d72f"
uuid = "5d786b92-1e48-4d6f-9151-6b4477ca9bed"
version = "0.1.5"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.Tricks]]
git-tree-sha1 = "6bac775f2d42a611cdfcd1fb217ee719630c4175"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.6"

[[deps.URIs]]
git-tree-sha1 = "97bbe755a53fe859669cd907f2d96aee8d2c1355"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.3.0"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.XML2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "58443b63fb7e465a8a7210828c91c08b92132dff"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.9.14+0"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
"""

# ╔═╡ Cell order:
# ╠═ddb7022e-5404-4278-9069-97d9730f277e
# ╠═60d603c3-c1e7-4d49-820f-288d20de70f5
# ╠═6a3614fb-81bd-474d-85cf-06725846a6c0
# ╟─004b0769-ee4a-4749-86eb-97a3c2322452
# ╟─95fd01d9-2555-4e5b-a044-eab02e2967bf
# ╠═2bee2fc7-3322-457f-a835-028c80eaf059
# ╠═a0057e4c-0bcf-4970-8a2b-0412ad5af510
# ╠═3e93e57c-3660-416f-9874-d43abf99e60e
# ╠═4be56e57-fea0-4fbe-9659-44bed594b1b2
# ╠═c9f17f9f-766a-4137-92c5-f8173561a7bc
# ╠═ab7186a4-2287-41da-a939-70f142bfeacd
# ╠═a31d893d-2cde-4228-a506-6af013fe1f3e
# ╠═f4d1018b-8f25-4478-91b8-ea55e66fe542
# ╟─dbb5e02a-2485-4ada-98d1-cc24fd6fc418
# ╟─83130e69-9b67-44b5-ad32-500162abc0d2
# ╟─5b7892c6-ca5c-4c3a-b5d8-0a6323ee2fa9
# ╠═88e1e91d-0d48-42e0-b4ab-4866624fd745
# ╟─2582ae89-616f-4a08-be81-0875362c1f7e
# ╠═c5e00f30-e734-4b59-97b9-8e5f59fd131e
# ╠═0b81d3ff-fa78-48c3-878c-24f9d6a34f20
# ╠═02e00e09-76a5-4f38-8557-4d9caf280b4c
# ╠═01a2336a-5c04-4d5a-bb0b-a9c704517dbf
# ╠═c0768146-5ea0-4736-94f8-2c1a2affa922
# ╠═8781d8d4-0dff-4b24-9500-6ba4ec586f9b
# ╟─d83ee9b9-d255-4217-a776-3b0f4f168c8f
# ╟─41b00a73-f42d-4e9e-86bb-49ff9105d949
# ╠═e8169711-6e94-45e0-9c41-b4d4692af328
# ╠═6eb94b8c-b972-4c80-9644-1bd6568dc943
# ╠═149b7852-ae23-447a-80bb-24cdd7993cfe
# ╠═68bff1d9-8fe4-4b88-82a2-49bbf6209019
# ╠═0fbcf5d1-b342-427c-a09d-e2f84725ba7f
# ╠═0abe998c-f69c-49de-a49f-6c4bbcb6c4e1
# ╠═43969dd1-f175-4399-8758-5a69f94595e7
# ╠═b14f33ae-89a7-473b-ac9b-1db0208faca7
# ╠═d45c8768-87e2-4f3c-8763-089ec43f1733
# ╟─ec4ac489-8b49-4c2d-be87-21bb3f70e06a
# ╠═c64ebd9b-66a3-4f6c-8f8b-36f6b9ce8f19
# ╠═fb914eec-bc9c-4dd4-b92e-f507c7d0b150
# ╠═680b5653-a0a0-48ad-87ca-583a1655a05c
# ╠═c012ae32-3b48-460c-8b1a-0b3e06f5fda0
# ╠═06bfaeee-a6ee-439c-b965-94d0455b0337
# ╠═35b80456-039e-45bc-963e-5466a3e9c3a7
# ╠═a965eb6b-8c70-4986-a7b1-99c820c45716
# ╠═140990ab-0a8c-4000-b17d-30e2f33dfd5f
# ╠═9b12c862-3604-4046-8d68-89dd2d198883
# ╟─a24bf899-87b0-4a2e-a6d4-30ac2aad4820
# ╠═d7098dc2-fe08-4545-921c-6ad3d2648c91
# ╟─2bba13d3-0c1d-4d17-bd70-526ce70407fb
# ╠═fd5f6637-3223-4f0b-94a6-ace86f5a5926
# ╠═feaed8af-05d0-4b80-9f69-8f827f9343a8
# ╠═4a7a342d-4bf2-455d-9cf9-52a827e180d4
# ╠═b5b07aac-1681-46ac-a234-198ba8261882
# ╠═d78c58e5-3ecb-45ee-972e-20fc90ece3cc
# ╠═98fb1e6a-c57c-4d66-972f-3471c6c15dd7
# ╠═6775885d-0340-462e-bdeb-1e9076d94925
# ╠═444502c9-33b5-4bb2-9a8d-a8d8e1adb632
# ╠═544518ea-d36d-4e80-855e-93895a8cc35d
# ╟─4489fbec-39b9-454f-ad17-3a1101d335ce
# ╠═8eac52e6-6a5e-4519-9b4c-80aadbf27573
# ╠═32540d48-becf-482a-990c-4cd4d13d93f3
# ╠═a8ae5287-e7b6-4b68-ac26-4bc55ee86fe6
# ╠═6ee83d91-b1d1-4b1e-95ca-6874e44167da
# ╠═5ec6013c-da21-4cdb-b43f-16d997bc8446
# ╠═adc183d3-2615-4334-88f0-2f8f0876b4b7
# ╠═bb5bca01-8f95-49a5-8e50-2ad013c6b804
# ╠═48570953-88d3-4010-a5e3-2034bda26413
# ╟─9979265f-60dd-42d4-9384-afaf4bf53ba2
# ╠═cebba3d4-f255-4039-bba4-0673ac4e700b
# ╠═2087dbd4-ea11-450f-92e3-4c24f3fa8f76
# ╠═b007e5cc-d7c3-4275-86fd-9098bc398b23
# ╠═5f93b932-6739-4b7e-bfdb-1bc1f7d57e65
# ╟─96aa002c-cebc-41f7-97cf-ecd02081b6ce
# ╠═866746a1-8102-431c-94e5-f93f6c98e825
# ╟─d15f2d13-0885-4da2-950d-fbbdd83f3907
# ╠═9cb9559a-cbe4-4a4a-b974-cb9a3573f67d
# ╠═0e1a2d5b-16da-49e9-98b3-6f1202fd0fa1
# ╠═afff6777-1fec-41ee-bbba-b99dab0fd008
# ╠═fbfcd2b0-3fb0-4999-ba59-4706437a501e
# ╠═5c69b7bd-6b18-496f-bcd5-3251a5eb0dd8
# ╠═e2fc5eab-e333-4ff8-951b-89fdfe40eef8
# ╠═d276b28e-a379-4804-ad25-f7d396b4ffb6
# ╠═35d20fb6-be54-4d6c-b6aa-5bc2529dafea
# ╟─77617779-76f0-4dec-aeea-cda321c71c9e
# ╠═190e776a-600e-41a4-b4de-08884036d610
# ╠═e49944c7-e975-4018-b068-90b872b6d175
# ╠═db665156-3a33-4c33-a979-74ef2c9f5792
# ╟─7ec64792-82d4-454d-83ce-d507d66e80e7
# ╠═729efdbc-9556-4d34-bcef-1dfff2fba6bb
# ╠═ccdea15d-1182-4d96-a7ab-26aa59a6002e
# ╠═811bffb7-1041-4f96-b2e6-f24ddce8d753
# ╠═c0d7eb1c-7b6f-446f-ab50-7d7a49a5b1b1
# ╠═1780b6d1-5e53-48e0-8675-f78645e7c576
# ╠═669ca7b1-9433-4391-b849-2f1cc7f4aa49
# ╠═e6e791d7-0f29-404a-8bdf-0c5f25d48da7
# ╠═2234f31d-89f3-4e58-8d89-e7ae9aa5b2db
# ╠═29a3e3f4-1c7a-44e4-89c2-ce12d31f4fd7
# ╟─4d78b60b-7311-4735-892b-1719729611d7
# ╠═276ef05c-25b3-4450-9dfc-9bdd9525c00c
# ╠═291dec1b-a998-4c56-b06f-008cd3a6ccd7
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
