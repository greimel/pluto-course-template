Dict(
    :main => [
        "welcome" => collections["welcome"].pages,
        "Preliminaries" => collections["preliminaries"].pages,
        "Module 2: Social Science & Data Science" => collections["module2"].pages,
        #"Module 3: Climate Science" => collections["module3"].pages,

    ],
    :about => Dict(
        :authors => [
            (name = "Instructor One", url = "https://www.the-one.eu"),
            (name = "Second Instructor", url = "https://www.the-second.com")
        ],
        :title => "A Great Course",
        :subtitle => "Even Greater Than You Thought",
        :term => "Spring 2023",
        :institution => "University of Greatness",
        :institution_url => "http://www.uva.nl",
        :institution_logo => "julia-logo-color.svg",
        :institution_logo_darkmode => "julia-logo-dark.svg"
    )
)