$(function(){
  var user_id = $('#me').attr('user_id');
  var rl = null;

  function buildMESSAGE(message) {
    if (user_id === message.user_id){
      rl = 'right';
    }else{
      rl = 'left';
    }
   var messages = $('#messages').append('<div class="message '+ rl +'"><div class="message_box"><div class="message_content" data-id=' + message.id + '><div class="message_text">' + message.content + '</div></div></div></div><div class="clear"></div>');
  }

  $(function(){
    setInterval(update, 10000);
    //10000ミリ秒ごとにupdateという関数を実行する
  });

    function update(){
      console.log($('.message_content'));
      if($('.message_content')[0]){ //もし'messages'というクラスがあったら
        var message_id = $('.message_content:last').data('id'); //一番最後にある'messages'というクラスの'id'というデータ属性を取得し、'message_id'という変数に代入
        console.log(message_id);
      } else { //ない場合は
        var message_id = 0 //0を代入
      }
      $.ajax({ //ajax通信で以下のことを行う
        url: location.href, //urlは現在のページを指定
        type: 'GET', //メソッドを指定
        data: { //railsに引き渡すデータは
          message: { id: message_id } //このような形(paramsの形をしています)で、'id'には'message_id'を入れる
        },
        dataType: 'json' //データはjson形式
      })
      .done(function(data){ //通信したら、成功しようがしまいが受け取ったデータ（@new_message)を引数にとって以下のことを行う
        $.each(data, function(i, data){ //'data'を'data'に代入してeachで回す
          buildMESSAGE(data); //buildMESSAGEを呼び出す
        });
      }).fail(function(data){
        console.log('fail')
      });
  }
});



