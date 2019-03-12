$(function(){
  function buildMESSAGE(message) {
    var messages = $('#messages-area').append('<li class="messages" data-id=' + message.id + '><strong>' + message.content + '</strong></li><hr>');
  }
    $(function(){
      setInterval(update, 10000);
      //10000ミリ秒ごとにupdateという関数を実行する
    });

    function update(){
      console.log($('.messages'));
      if($('.messages')[0]){ //もし'messages'というクラスがあったら
        var message_id = $('.messages:last').data('id'); //一番最後にある'messages'というクラスの'id'というデータ属性を取得し、'message_id'という変数に代入
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
       .always(function(data){ //通信したら、成功しようがしまいが受け取ったデータ（@new_message)を引数にとって以下のことを行う
        console.log(data);
        $.each(data, function(i, data){ //'data'を'data'に代入してeachで回す
          buildMESSAGE(data); //buildMESSAGEを呼び出す
        });
      });
    }
  });