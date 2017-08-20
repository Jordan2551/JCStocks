//This is a file that is used for ajax callback handling when dealing with stocks

var init_stock_lookup;

//To understand how this works, read http://api.jquery.com/ajaxsuccess/
init_stock_lookup = function () {

    //Right before the ajax submission happens; show the spinner
    $('#stock-lookup-form').on('ajax:before', function(event, data, status){
        show_spinner();
    });

    //Right after the ajax submission completes(successfully); hide the spinner
    $('#stock-lookup-form').on('ajax:after', function(event, data, status){
        hide_spinner();
    });

    //When the ajax request succeeds; provide the form with the new data
    $('#stock-lookup-form').on('ajax:success',function (event, data, status) {
        $('#stock-lookup').replaceWith(data)
        /* The reason for the line below is because when we make the ajax request we replace the entire dom with
           the same page but with the stock data in place. This causes the even listener to reset. Thereofore,
           We call this method again so that we reassign the .ajaxSuccess event handler to stock-lookup-form in case
           another stock search is needed.*/
        init_stock_lookup();
    });

    //When the ajax request fails; provide the form with an error message and hide the spinner
    $('#stock-lookup-form').on('ajax:error', function(event, xhr, status, error){
        $('#stock-lo okup-results').replaceWith('');
        $('#stock-lookup-errors').replaceWith('Stock was not found.');
        hide_spinner();
    });

}

$(document).ready(function () {
    init_stock_lookup();//Register the even listener for the stock lookup call
});

