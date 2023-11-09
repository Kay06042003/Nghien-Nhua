const toggler = document.querySelector(".btn");
toggler.addEventListener("click", function () {
    document.querySelector("#sidebar").classList.toggle("collapsed");
});

var collapse = document.getElementsByClassName("collapse");
for (var i = 0; i < collapse.length; i++) {
    collapse[i].addEventListener("click", function () {
        collapse[i].classList.remove("show");
    })
}