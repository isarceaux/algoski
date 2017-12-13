//= require jquery.min
//= require jquery_ujs
//= require bootstrap.min
//= require pace.min
//= require modernizr.min
//= require wow.min
//= require jquery.nicescroll
//= require jquery.app

//Data Tables
//= require dataTables/jquery.dataTables
//= require dataTables/bootstrap/3/jquery.dataTables.bootstrap

$(document).ready(function() {
    $('#datatable').dataTable({
        "language": {
          "url": "//cdn.datatables.net/plug-ins/1.10.16/i18n/French.json"
        },

        initComplete: function () {
            this.api().columns().every( function () {
                var column = this;
                var select = $('<select><option value=""></option></select>')
                    .appendTo( $(column.footer()).empty() )
                    .on( 'change', function () {
                        var val = $.fn.dataTable.util.escapeRegex(
                            $(this).val()
                        );
 
                        column
                            .search( val ? '^'+val+'$' : '', true, false )
                            .draw();
                    } );
 
                column.data().unique().sort().each( function ( d, j ) {
                    select.append( '<option value="'+d+'">'+d+'</option>' )
                } );
            } );
        }        

    });
});

$(document).ready(function() {
    $('#housings').DataTable({
      dom: 'Bfrtip',
      buttons: [
            'csv', 'excel'
        ]
    });
} );

// $(document).ready(function() {
//     $('#dataTable').dataTable( {

//       "language": {
//           "url": "//cdn.datatables.net/plug-ins/1.10.16/i18n/French.json"
//       },

//         initComplete: function () {
//             this.api().columns().every( function () {
//                 var column = this;
//                 var select = $('<select><option value=""></option></select>')
//                     .appendTo( $(column.footer()).empty() )
//                     .on( 'change', function () {
//                         var val = $.fn.dataTable.util.escapeRegex(
//                             $(this).val()
//                         );
 
//                         column
//                             .search( val ? '^'+val+'$' : '', true, false )
//                             .draw();
//                     } );
 
//                 column.data().unique().sort().each( function ( d, j ) {
//                     select.append( '<option value="'+d+'">'+d+'</option>' )
//                 } );
//             } );
//         }
//     } );
// } );