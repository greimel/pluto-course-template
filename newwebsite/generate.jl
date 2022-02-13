### A Pluto.jl notebook ###
# v0.18.0

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

# ╔═╡ 3f2428bc-4ba4-11ec-3f1b-1326777bfdd2
import Pkg

# ╔═╡ 257b4034-3ef7-4a7b-8384-c8d25e618ae2
Pkg.activate("."); Pkg.instantiate()

# ╔═╡ ddb7022e-5404-4278-9069-97d9730f277e
using JSON3

# ╔═╡ 60d603c3-c1e7-4d49-820f-288d20de70f5
using HypertextLiteral

# ╔═╡ 6a3614fb-81bd-474d-85cf-06725846a6c0
using PlutoUI

# ╔═╡ b14f33ae-89a7-473b-ac9b-1db0208faca7
using PlutoSliderServer

# ╔═╡ d45c8768-87e2-4f3c-8763-089ec43f1733
using Pluto: without_pluto_file_extension

# ╔═╡ c64ebd9b-66a3-4f6c-8f8b-36f6b9ce8f19
using PlutoHooks

# ╔═╡ fb914eec-bc9c-4dd4-b92e-f507c7d0b150
using PlutoHooks: @use_task

# ╔═╡ 7c55e578-f269-4570-bd98-b1bf22eb0f36
using PlutoTest: @skip_as_script

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

# ╔═╡ ab7186a4-2287-41da-a939-70f142bfeacd
TERM = "Spring 2022"

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
	PREPATH = "18S191-reduced"
	@skip_as_script PREPATH = ""
end

# ╔═╡ 2582ae89-616f-4a08-be81-0875362c1f7e
md"""
#### Add notebook header?
"""

# ╔═╡ 01a2336a-5c04-4d5a-bb0b-a9c704517dbf
pages = [
	(page = "/reviews/", title = "Class Reviews"),
	(page = "/logistics/", title = "Class Logistics"),
	(page = "/syllabus/", title = "Syllabus and videos"),
	(page = "/installation/", title = "Software installation"),
	(page = "/cheatsheets/", title = "Cheatsheets"),
	(page = "/semesters/", title = "Previous semesters")
]

# ╔═╡ c0768146-5ea0-4736-94f8-2c1a2affa922
SLASH_PREPATH = !isempty(PREPATH) ? "/" * PREPATH : ""

# ╔═╡ 02e00e09-76a5-4f38-8557-4d9caf280b4c
homepage = (page = "/index.html", href = "$SLASH_PREPATH/", title = "Welcome")

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
book_model = JSON3.read(read("./book_model_small.json", String), Vector{Chapter})

# ╔═╡ 91ca4a45-137c-4378-803b-c6b2f036ac96
import Pluto

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

# ╔═╡ fd5f6637-3223-4f0b-94a6-ace86f5a5926
function instructors(INSTRUCTORS)
	tmp = map(INSTRUCTORS) do (; name, href)
		"""
		<a href="$href">$name</a>
		"""
	end
	join(tmp, ", ", "&amp " ) |> HTML
end

# ╔═╡ 3e93e57c-3660-416f-9874-d43abf99e60e
INSTRUCTORS = [
	(name = "Person 1", href = ""),
	(name = "Person 2", href = "")
] |> instructors

# ╔═╡ feaed8af-05d0-4b80-9f69-8f827f9343a8
bold(text) = @htl("<b>$(text)</b>")

# ╔═╡ 4a7a342d-4bf2-455d-9cf9-52a827e180d4
emph(text) = @htl("<em>$(text)</em>")

# ╔═╡ 98fb1e6a-c57c-4d66-972f-3471c6c15dd7
function sidebar_page(; page, title, href="$(SLASH_PREPATH)$(page)", isbold = false)
	title = isbold ? bold(title) : title
	@htl("""
	<a class="sidebar-nav-item {{ispage $(page)}}active{{end}}" href="$(href)">$(title)</a>
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
    <img src="$(SLASH_PREPATH)/assets/julia-logo.svg" style="margin-left:1em; width: 80px; height: auto; display: inline">
    <div style="font-weight: bold; margin-bottom: 0.5em"><a href="$(SLASH_PREPATH)/semesters/">$(TERM)</a> <span style="opacity: 0.6;">| $(INSTITUTION)</span></div>
    <h1><a href="$(SLASH_PREPATH)/">$(TITLE)</a></h1>
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

# ╔═╡ b007e5cc-d7c3-4275-86fd-9098bc398b23
function notebook_header(section::Section, chapter_number::Integer, section_number::Integer)
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
    height: 500px;
    pointer-events: none;
    "></div>

    <div style="
    height: 500px;
    width: 100%;
    background: #282936;
    color: #fff;
    padding-top: 68px;
    ">
    <span style="
    font-family: Vollkorn, serif;
    font-weight: 700;
    font-feature-settings: 'lnum', 'pnum';
    "> <p style="
    font-size: 1.5rem;
    opacity: .8;
    "><em>Section $(chapter_number).$(section_number)</em></p>
    <p style="text-align: center; font-size: 2rem;">
    <em> $(section.name) </em>
    </p>

    <p style="
    font-size: 1.5rem;
    text-align: center;
    opacity: .8;
    "><em>Lecture Video</em></p>
    <div style="display: flex; justify-content: center;">
    <div  notthestyle="position: relative; right: 0; top: 0; z-index: 300;">
    <iframe src="https://www.youtube.com/embed/$(section.video_id)" width=400 height=250  frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe></div>
    </div>
    </div>

    <style>
    body {
    overflow-x: hidden;
    }
    </style>""")
end

# ╔═╡ 48570953-88d3-4010-a5e3-2034bda26413
if show_header_preview === true
	notebook_header(book_model[1].contents[1], 1, 1)
end

# ╔═╡ 5f93b932-6739-4b7e-bfdb-1bc1f7d57e65
notebook_header_code(args...) = "HTML($(repr(string(notebook_header(args...)))))"

# ╔═╡ f731fc20-2660-484c-bcc7-fbc1809a3b4a
notebook_header_code(book_model[1].contents[1], 1, 1)

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
		@info "removed" franklin_page_dir
	end
	mkpath(franklin_page_dir)
	franklin_config()
	cd(website_dir)
	Franklin.optimize(; minify = false)
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
index_footer = @htl("""
<!-- Global site tag (gtag.js) - Google Analytics -->
    <script async src="https://www.googletagmanager.com/gtag/js?id=UA-28835595-11"></script>
    <script>
      window.dataLayer = window.dataLayer || [];
      function gtag(){dataLayer.push(arguments);}
      gtag('js', new Date());
      gtag('config', 'UA-28835595-11');
    </script>
	""");

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
		header_code = notebook_header_code(section, chapter_number, section_number)
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
	
	PlutoSliderServer.export_directory(pluto_notebooks_output_dir; Export_cache_dir=pluto_cache_dir)
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

# ╔═╡ Cell order:
# ╠═3f2428bc-4ba4-11ec-3f1b-1326777bfdd2
# ╠═257b4034-3ef7-4a7b-8384-c8d25e618ae2
# ╠═ddb7022e-5404-4278-9069-97d9730f277e
# ╠═60d603c3-c1e7-4d49-820f-288d20de70f5
# ╠═6a3614fb-81bd-474d-85cf-06725846a6c0
# ╟─004b0769-ee4a-4749-86eb-97a3c2322452
# ╟─95fd01d9-2555-4e5b-a044-eab02e2967bf
# ╠═2bee2fc7-3322-457f-a835-028c80eaf059
# ╠═a0057e4c-0bcf-4970-8a2b-0412ad5af510
# ╠═3e93e57c-3660-416f-9874-d43abf99e60e
# ╠═4be56e57-fea0-4fbe-9659-44bed594b1b2
# ╠═ab7186a4-2287-41da-a939-70f142bfeacd
# ╟─83130e69-9b67-44b5-ad32-500162abc0d2
# ╟─5b7892c6-ca5c-4c3a-b5d8-0a6323ee2fa9
# ╠═88e1e91d-0d48-42e0-b4ab-4866624fd745
# ╟─2582ae89-616f-4a08-be81-0875362c1f7e
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
# ╠═91ca4a45-137c-4378-803b-c6b2f036ac96
# ╠═d45c8768-87e2-4f3c-8763-089ec43f1733
# ╟─ec4ac489-8b49-4c2d-be87-21bb3f70e06a
# ╠═c64ebd9b-66a3-4f6c-8f8b-36f6b9ce8f19
# ╠═fb914eec-bc9c-4dd4-b92e-f507c7d0b150
# ╠═680b5653-a0a0-48ad-87ca-583a1655a05c
# ╠═7c55e578-f269-4570-bd98-b1bf22eb0f36
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
# ╠═f731fc20-2660-484c-bcc7-fbc1809a3b4a
# ╠═48570953-88d3-4010-a5e3-2034bda26413
# ╟─9979265f-60dd-42d4-9384-afaf4bf53ba2
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
