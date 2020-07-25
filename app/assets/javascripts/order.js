$(function(){
   $( 'input[name="optionsRadios"]:radio' ).change( function() {
      var radioval = $(this).val();
      if(radioval == 1){
         $('#inputother_1').removeAttr('disabled');
         $('#inputother_2').attr('disabled','disabled');
         $('#inputother_3').attr('disabled','disabled');
         $('#inputother_4').attr('disabled','disabled');
      } else if(radioval == 2) {
         $('#inputother_2').removeAttr('disabled');
         $('#inputother_3').removeAttr('disabled');
         $('#inputother_4').removeAttr('disabled');
         $('#inputother_1').attr('disabled','disabled');
      } else {
         $('#inputother_1').attr('disabled','disabled');
         $('#inputother_2').attr('disabled','disabled');
         $('#inputother_3').attr('disabled','disabled');
         $('#inputother_4').attr('disabled','disabled');
      }
   });
});

$(function(){
    $("form").submit(function(){
        //エラーの初期化
        $("p.error").remove();
        $("dl dd").removeClass("error");
        $(":text,textarea").filter(".validate").each(function(){
            var post_radio = $('input[name="optionsRadios"]:checked').val();
            //必須項目のチェック
            $(this).filter(".required_postcode").each(function(){
                if(post_radio == 2){
                   if($(this).val()==""){
                       $(this).parent().prepend("<p class='error'>※郵便番号を入力してください</p>")
                  } else if(!$(this).val().match(/\d{7}/)) {
                       $(this).parent().prepend("<p class='error'>※数字7桁で入力してください（半角）</p>")
                  }
                }
            })
            $(this).filter(".required_address").each(function(){
                if($(this).val()=="" && post_radio == 2){
                    $(this).parent().prepend("<p class='error'>※住所を入力してください</p>")
                }
            })
            $(this).filter(".required_name").each(function(){
                if($(this).val()=="" && post_radio == 2){
                    $(this).parent().prepend("<p class='error'>※宛名を入力してください</p>")
                }
            })
            //メールアドレスのチェック
            $(this).filter(".mail").each(function(){
                if($(this).val() && !$(this).val().match(/.+@.+\..+/g)){
                    $(this).parent().prepend("<p class='error'>メールアドレスの形式が異なります</p>")
                }
            })
        })
        // その他項目のチェック
        $(".validate.add_text").each(function(){
            if($(this).attr("checked")==true && $("input[name="+$(this).attr("name").replace(/^(.+)$/, "$1_text")+"]").val()==""){
                $(this).parent().prepend("<p class='error'>その他の項目を入力してください。</p>")
            }
        })
        //エラーの際の処理
        if($("p.error").size() > 0){
                $('html,body').animate({ scrollTop: $("p.error:first").offset().top-40 }, 'slow');
                $("p.error").parent().addClass("error");
                return false;
        }
    })
})