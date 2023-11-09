// JS box support

var supportBox = document.querySelector(".support_container");
var supportElement = document.querySelector(".support");
console.log(supportBox)

supportElement.addEventListener('mouseenter', () => {
    supportBox.classList.add('showSupportBox');
});

supportElement.addEventListener('mouseleave', () => {
    supportBox.classList.remove('showSupportBox');
});

// Nav heigh scroll

$(document).ready(function () {
    $(window).scroll(function () {
        var position = $(this).scrollTop();
        if (position > 600) {
            $('.navContainer').addClass('navReduceHight');
        } else {
            $('.navContainer').removeClass('navReduceHight');
        }
    })
})

// navbar mobile
$(document).ready(function () {
    $(".navbar-toggler").click(function () {
        // Lấy giá trị của thuộc tính aria-expanded
        var ariaExpanded = $(this).attr("aria-expanded");
        var $navbarToggler = $(this);

        if (ariaExpanded === "true") {
            // Trạng thái là true
            $navbarToggler.append('<i class="fas fa-times close_navbar-icon"></i>');
            console.log("aria-expanded là true");
        } else if (ariaExpanded === "false") {
            // Trạng thái là false
            $navbarToggler.find('.fa-times.close_navbar-icon').remove();
            console.log("aria-expanded là false");
        }
    });
});
