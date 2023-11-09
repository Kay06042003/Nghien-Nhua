$(document).ready(function () {
    $('.thumbPhoto').slick({
        infinite: true,
        slidesToShow: 4,
        slidesToScroll: 4,
        arrows: false,
    });
});

function galleryFunction(img) {
    var fullImg = document.getElementById("imageBox");
    fullImg.src = img.src;
}

let slideIndex = 1;

showSlides(slideIndex);

function plusSlides(n) {
    showSlides(slideIndex += n)
}

function currentSlide(n) {
    showSlides(slideIndex = n);
}

function showSlides(n) {
    let i;
    let slides = document.getElementsByClassName("imageItems");
    let thumb = document.getElementsByClassName("thumbImage_Items");
    if (n > slides.length) {
        slideIndex = 1
    }
    if (n < 1) {
        slideIndex = slides.length
    }
    for (i = 0; i < slides.length; i++) {
        slides[i].style.display = "none";
    }
    for (i = 0; i < thumb.length; i++) {
        thumb[i].className = thumb[i].className.replace("active", "");
    }

    slides[slideIndex - 1].style.display = "block"
    thumb[slideIndex - 1].className += " active";
}

var hovertopGallery = document.getElementById("topGallery");
var btn = document.getElementsByClassName("btnGallery");
hovertopGallery.addEventListener("mouseover", function () {
    for (var i = 0; i < btn.length; i++) {
        btn[i].style.display = "block";
        btn[i].style.opacity = 1;
    }
})
hovertopGallery.addEventListener("mouseout", function () {
    for (var i = 0; i < btn.length; i++) {
        btn[i].style.opacity = 0;
        setTimeout(function () {
            btn[i].style.display = "none";
        }, 300); // Thời gian transition là 0.3 giây
    }
});


var quantityInput = document.getElementById("quantityInput");
var addButton = document.getElementById("button-addon2");
var minusButton = document.getElementById("button-addon1");

addButton.addEventListener('click', function () {
    quantityInput.value = parseInt(quantityInput.value) + 1;
    quantityInput.placeholder = quantityInput.value
});

minusButton.addEventListener('click', function () {
    var currentValue = parseInt(quantityInput.value);
    if (currentValue > 1) {
        quantityInput.value = currentValue - 1;
    }
    quantityInput.placeholder = quantityInput.value
});