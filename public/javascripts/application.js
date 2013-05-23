$(function() {

  var client = new Faye.Client('/faye');

  client.subscribe('/info/' + ACCESS_TOKEN, function(message) {
    console.log(message);
    $pause_button = $('button.pause');
    $love_button = $('button.love');
    if (message.radio.is_paused == 'true') {
      $pause_button.text('播放');
    } else {
      $pause_button.text('暂停');
    }
    if (message.radio.selected_like == 'true') {
      $love_button.text('取消喜欢');
    } else {
      $love_button.text('喜欢');
    }
    $('#cover').html('<img src="' + message.song.coverUrl + '" />');
    $('#channel').html('频道: ' + message.song.channelName);
    $('#artist').html('歌手: ' + message.song.artistName);
    $('#song-name').html('歌名: ' + message.song.songName);
  });

  $buttons = $('button');
  $buttons.click(function() {
    $this = $(this);
    var cmd = $this.data('cmd')
    $.get('/douban/' + cmd + '?access_token=' + ACCESS_TOKEN)
  });

  setTimeout(function() {
    $.get('/douban/get_info?access_token=' + ACCESS_TOKEN);
  }, 2000);

});
