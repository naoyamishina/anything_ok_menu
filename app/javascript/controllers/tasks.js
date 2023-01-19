document.addEventListener("tubolinks:load", function () {
    document.querySelectorAll("td").forEach(function(td) {
        td.addEventListener("mouseover", function(e) {
            e.currentTarget.style.style.backgroundColor = "#eff" ;
        });

        td.addEventListener("mouseout", function(e) {
            e.currentTarget.style.backgroundColor = "";
        })
    })
})