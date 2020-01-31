import "android.webkit.WebView"
webView.addJavascriptInterface({},"JsInterface")
-- Fusion App 漏洞修复代码，其实未打开网页时可以忽略

menuBtn.onClick=function()
  退出页面()
end
-- 设置伪侧滑栏菜单按钮（即返回按钮）点击事件

sidebarParent =sidebar.getParent()
sidebarParent.removeView(sidebar)
-- 杀掉侧滑栏

-- 需要在项目 / 子页面里启用侧滑栏
-- 感谢 酷安@卿三公 提供代码

import "http"
-- 导入 http 模块，需要在项目主页里导入，
-- 子页面最好也导入一下

InputLayout={
  LinearLayout;
  orientation="vertical";
  Focusable=true,
  FocusableInTouchMode=true,
  {
    EditText;
    hint="在这里输入";
    layout_marginTop="5dp";
    layout_width="80%w";
    layout_gravity="center",
    InputType="number";
    id="edit";
  };
};

AlertDialog.Builder(this)
.setTitle("输入 UID")
.setView(loadlayout(InputLayout))
.setPositiveButton("确定",{onClick=function(v) lolol()end})
.setNegativeButton("取消",nil)
.show()
-- 显示输入框，
-- 如果后期知道如何从其他页面调用，可能会修改这个逻辑

function lolol()
  -- lolol() 的事件
  a=http.get("https://api.bilibili.com/x/web-interface/card?mid="..edit.Text)
  -- 基本 api
  
  code=a:match([["code":(.-),]])
  name=a:match([["name":"(.-)"]])
  avatarpic=a:match([["face":"(.-)"]])
  sign= a:match([["sign":"(.-)"]])
  uid=a:match([["mid":"(.-)"]])
  lvl= a:match([["current_level":(.-),]])
  ban= a:match([["spacesta":(.-),]])
  vip= a:match([["vipType":(.-),]])
  status=a:match([["vipStatus":(.-),]])
  count=a:match([["archive_count":(.-),]])
  follow=a:match([["friend":(.-),]])
  fans=a:match([["fans":(.-),]])
  -- 依次是 返回代码、昵称、头像、签名、UID、等级、封禁状态、大会员类型、大会员状态、视频稿件数量、关注数、粉丝数

  officalapi=http.get("https://api.bilibili.com/x/space/acc/info?mid="..edit.Text)
  -- 与认证信息相关的 API，不过拿它当主 API 亦可
  officalstatus= officalapi:match([["role":(.-),]])
  officaltitle= officalapi:match([["title":"(.-)",]])
  desc=officalapi:match([["desc":"(.-)",]])
  -- 认证状态、内容、子标题

  topvid=http.get("https://api.bilibili.com/x/space/top/arc?vmid="..edit.Text)
  -- PC 端个人空间 针对粉丝的置顶视频
  vidcode=topvid:match([["code":(.-),]])
  -- 状态代码
  
  if vidcode == "53016" or vidcode == "-400" then
    vidname="0"
    play="0"
    danmaku="0"
    aid="0"
    -- 没有置顶视频时附的一堆值
  else
    vidname=topvid:match([["title":"(.-)"]])
    vidpic=topvid:match([["pic":"(.-)"]])
    play=topvid:match([["view":(.-),]])
    danmaku=topvid:match([["danmaku":(.-),]])
    aid=topvid:match([["aid":(.-),]])
    -- 视频名、封面、播放量、弹幕数、av 号
  end

  if officalstatus == "3" then
    officalclr="#FF00BBFF" -- 对应企业认证
  elseif officalstatus == "2" or officalstatus == "1" then
    officalclr="#FFFFAE00" -- 对应个人认证
  else
    officalclr="#212121" -- 无认证时乱附的无用值
  end

  if code == "-404" then
    toasttext="你输了一个无效的 UID，请换个 UID 重试，或者检查是否输入错误"
    toastbkg="#EEFF3333"
    ToastLay={
      LinearLayout;
      orientation="vertical";
      layout_width="fill";
      layout_height="fill";
      {
        LinearLayout;
        gravity="center|left";
        background=toastbkg; 
        layout_width="100%w";
        {
          TextView;
          text=toasttext;
          textColor="#ffffff";
          layout_margin="15dp";
          textSize="15dp";
        };
      };
    };

    ToastLayout=loadlayout(ToastLay)
    local toast=Toast.makeText(activity,"qwq",Toast.LENGTH_SHORT).setView(ToastLayout).setGravity(Gravity.BOTTOM, 0, 0).show()
    -- UID 不存在时的 Toast 提示
    -- 这套 Toast 框架是整个 Toolb 的 Toast 实现
  elseif code == "-400" then
    toasttext="你输的是 UID 吗？？？B 站的 API 都被你搞爆炸了！！（雾）"
    toastbkg="#EEFF3333"
    ToastLay={
      LinearLayout;
      orientation="vertical";
      layout_width="fill";
      layout_height="fill";
      {
        LinearLayout;
        gravity="center|left";
        background=toastbkg; 
        layout_width="100%w";
        {
          TextView;
          text=toasttext;
          textColor="#ffffff";
          layout_margin="15dp";
          textSize="15dp";
        };
      };
    };

    ToastLayout=loadlayout(ToastLay)
    local toast=Toast.makeText(activity,"qwq",Toast.LENGTH_SHORT).setView(ToastLayout).setGravity(Gravity.BOTTOM, 0, 0).show()
    -- UID 数据超出 API 上限时的提示
  else
  -- 下面正片
    if vip=="0" then
      viptype="未开通大会员"
      vipstatus=""
      vipclr="#000000"
      -- 未开通大会员时
      -- 类型、状态、昵称色彩
    elseif vip=="1" then
      viptype="大会员"
      if status == "0" then
        vipstatus="已过期"
        vipclr="#000000"
      elseif status == "1" then
        vipstatus=""
        vipclr="#000000"
      end
      -- 大会员
    elseif vip=="2" then
      viptype="年度大会员"
      if status == "0" then
        vipstatus="已过期"
        vipclr="#000000"
      elseif status == "1" then
        vipstatus=""
        vipclr="#fa82b6"
      end
      -- 年度大会员
    end

    if uid == "2919621" then
      sign="*Toolb 已和谐此签名*"
    end
    -- 彩蛋

    lay={
      LinearLayout;
      layout_width="fill";
      orientation="vertical";
      layout_height="fill";
      background="#ffffff";
      {
        ScrollView;
        layout_height="fill";
        layout_width="fill";
        {
          LinearLayout;
          layout_width="fill";
          orientation="vertical";
          layout_height="fill";
          {
            CircleImageView;
            layout_margin="30dp";
            id="avatar";
            layout_width="81dp";
            layout_height="81dp";
          };
          {
            TextView;
            layout_marginTop="0";
            layout_margin="30dp";
            textSize="32dp";
            text=name;
            textColor=vipclr;
            layout_marginBottom="0";
          };
          {
            TextView;
            textSize="18dp";
            text=sign;
            layout_marginTop="0";
            layout_margin="30dp";
            textIsSelectable=true;
          };
          {
            TextView;
            id="offical";
            layout_margin="30dp";
            layout_marginTop="0";
            textColor=officalclr;
          };
          {
            TextView;
            text="UID "..uid.." / Lv. "..lvl.." / "..viptype..""..vipstatus;
            layout_marginTop="0";
            layout_margin="30dp";
          };
          {
            TextView;
            id="fan";
            text="关注 "..follow.." / 粉丝 "..fans;
            layout_marginTop="0";
            layout_margin="30dp";
          };
          {
            LinearLayout;
            background="#22FD5454";
            gravity="center|left";
            layout_height="45dp";
            id="banned";
            layout_width="fill";
            layout_marginTop="0";
            {
              TextView;
              layout_marginLeft="30dp";
              text="WARNING！该用户已被封禁！";
              textColor="#fd5454";
            };
          };
          {
            LinearLayout;
            orientation="vertical";
            layout_height="fill";
            layout_width="fill";
            id="topvideoFrame";
            {
              TextView;
              layout_margin="30dp";
              textSize="24dp";
              text="UP 主置顶作品";
              textColor="#000000";
            };
            {
              CardView;
              radius="18dp";
              layout_margin="30dp";
              layout_height="30%h";
              layout_marginTop="0";
              layout_width="fill";
              {
                LinearLayout;
                id="topvideo";
                layout_height="fill";
                layout_width="fill";
                {
                  ImageView;
                  id="topvidview";
                  scaleType="centerCrop";
                  layout_height="fill";
                  layout_width="fill";
                };
              };
            };
            {
              TextView;
              textSize="21dp";
              text=vidname;
              layout_margin="30dp";
              layout_marginBottom="0";
              layout_marginTop="0";
              textColor="#363636";
            };
            {
              TextView;
              layout_margin="30dp";
              layout_marginTop="0";
              text="av"..aid.." / "..play.." 播放 / "..danmaku.." 弹幕";
            };
          };
          {
            CardView;
            radius="8dp";
            layout_margin="30dp";
            elevation="5dp";
            layout_width="fill";
            layout_height="54dp";
            {
              LinearLayout;
              gravity="center|left";
              layout_height="fill";
              id="video";
              layout_width="fill";
              orientation="horizontal";
              {
                TextView;
                textSize="16dp";
                layout_marginLeft="15dp";
                text="视频投稿";
                textColor="#000000";
              };
              {
                TextView;
                text=count;
                layout_marginLeft="15dp";
              };
            };
          };
          {
            CardView;
            radius="8dp";
            layout_marginTop="0";
            layout_margin="30dp";
            elevation="5dp";
            layout_width="fill";
            layout_height="54dp";
            {
              LinearLayout;
              gravity="center|left";
              layout_height="fill";
              id="article";
              layout_width="fill";
              orientation="horizontal";
              {
                TextView;
                textSize="16dp";
                layout_marginLeft="15dp";
                text="专栏投稿";
                textColor="#000000";
              };
            };
          };
          {
            CardView;
            radius="8dp";
            layout_marginTop="0";
            layout_margin="30dp";
            elevation="5dp";
            layout_width="fill";
            layout_height="54dp";
            {
              LinearLayout;
              gravity="center|left";
              layout_height="fill";
              id="dynamic";
              layout_width="fill";
              orientation="horizontal";
              {
                TextView;
                textSize="16dp";
                layout_marginLeft="15dp";
                text="动态内容";
                textColor="#000000";
              };
            };
          };
          {
            CardView;
            radius="8dp";
            layout_marginTop="0";
            layout_margin="30dp";
            elevation="5dp";
            layout_width="fill";
            layout_height="54dp";
            {
              LinearLayout;
              gravity="center|left";
              layout_height="fill";
              id="comingsoon";
              layout_width="fill";
              orientation="horizontal";
              {
                TextView;
                textSize="16dp";
                layout_marginLeft="15dp";
                text="即将到来……";
                textColor="#000000";
              };
            };
          };
        };
      };
    };
    -- 整块 Layout
    
    webView.addView(loadlayout(lay))
    -- 在 Fusion App 里调用 Layout

    设置顶栏标题(name)
    -- 用昵称设置顶栏标题

    avatar.setImageBitmap(loadbitmap(avatarpic))
    -- 设置头像显示

    if vidcode == "53016" or vidcode == "-400" then
      topvideoFrame.setVisibility(View.GONE)
    else
      topvidview.setImageBitmap(loadbitmap(vidpic))
    end
    -- 置顶视频块设置消失条件
    
    -- 一堆无意义的 onClick Function start
    video.onClick=function()
      toasttext="在做了，在做了（0%）"
      toastbkg="#EE212121"
      ToastLay={
        LinearLayout;
        orientation="vertical";
        layout_width="fill";
        layout_height="fill";
        {
          LinearLayout;
          gravity="center|left";
          background=toastbkg; 
          layout_width="100%w";
          {
            TextView;
            text=toasttext;
            textColor="#ffffff";
            layout_margin="15dp";
            textSize="15dp";
          };
        };
      };

      ToastLayout=loadlayout(ToastLay)
      local toast=Toast.makeText(activity,"qwq",Toast.LENGTH_SHORT).setView(ToastLayout).setGravity(Gravity.BOTTOM, 0, 0).show()
    end

    article.onClick=function()
      toasttext="在做了，在做了（0%）"
      toastbkg="#EE212121"
      ToastLay={
        LinearLayout;
        orientation="vertical";
        layout_width="fill";
        layout_height="fill";
        {
          LinearLayout;
          gravity="center|left";
          background=toastbkg; 
          layout_width="100%w";
          {
            TextView;
            text=toasttext;
            textColor="#ffffff";
            layout_margin="15dp";
            textSize="15dp";
          };
        };
      };

      ToastLayout=loadlayout(ToastLay)
      local toast=Toast.makeText(activity,"qwq",Toast.LENGTH_SHORT).setView(ToastLayout).setGravity(Gravity.BOTTOM, 0, 0).show()
    end

    dynamic.onClick=function()
      toasttext="在做了，在做了（0%）"
      toastbkg="#EE212121"
      ToastLay={
        LinearLayout;
        orientation="vertical";
        layout_width="fill";
        layout_height="fill";
        {
          LinearLayout;
          gravity="center|left";
          background=toastbkg; 
          layout_width="100%w";
          {
            TextView;
            text=toasttext;
            textColor="#ffffff";
            layout_margin="15dp";
            textSize="15dp";
          };
        };
      };

      ToastLayout=loadlayout(ToastLay)
      local toast=Toast.makeText(activity,"qwq",Toast.LENGTH_SHORT).setView(ToastLayout).setGravity(Gravity.BOTTOM, 0, 0).show()
    end
    -- 一堆无意义的 onClick Function end

    function 波纹(id,颜色)
      import "android.content.res.ColorStateList"
      local attrsArray = {android.R.attr.selectableItemBackgroundBorderless} 
      local typedArray =activity.obtainStyledAttributes(attrsArray) 
      ripple=typedArray.getResourceId(0,0) 
      Pretend=activity.Resources.getDrawable(ripple) 
      Pretend.setColor(ColorStateList(int[0].class{int{}},int{颜色}))
      id.setBackground(Pretend.setColor(ColorStateList(int[0].class{int{}},int{颜色})))
    end

    波纹(video,0xffbababa)
    波纹(article,0xffbababa)
    波纹(dynamic,0xffbababa)
    -- 点击时的水波，感谢原 Fusion App 论坛的 Ghost 大佬
    -- 需要赋 onClick Function 才能生效

    topvideo.onClick=function()
      进入子页面("pcnormal",{链接="https://www.bilibili.com/video/av"..aid})
    end
    -- 打开置顶视频的事件（需要自行修改子页面名称为自己的）
    
    if ban == "0" then
      banned.setVisibility(View.GONE)
    end
    -- 未封禁帐号设置隐藏“WARNING！该用户已被封禁！”的警告

    if officalstatus == "0" then
      offical.setVisibility(View.GONE)
      -- 未认证帐号隐藏认证相关区域
    else
      offical.setText(officaltitle.."\n"..desc)
      -- 设置认证相关文字，含子标题
    end

    fan.onClick=function()
      进入子页面("normal",{链接="https://space.bilibili.com/h5/follow?mid="..uid})
    end
    -- 点击关注 / 粉丝数时跳转到关注列表，需要自行修改子页面名称

    avatar.onClick=function()
      if avatarpic == "http://static.hdslb.com/images/member/noface.gif" then
        toasttext="这位用户似乎没有设置头像呢\n（说不定是被和谐了）"
        toastbkg="#EE212121"
        ToastLay={
          LinearLayout;
          orientation="vertical";
          layout_width="fill";
          layout_height="fill";
          {
            LinearLayout;
            gravity="center|left";
            background=toastbkg; 
            layout_width="100%w";
            {
              TextView;
              text=toasttext;
              textColor="#ffffff";
              layout_margin="15dp";
              textSize="15dp";
            };
          };
        };

        ToastLayout=loadlayout(ToastLay)
        local toast=Toast.makeText(activity,"qwq",Toast.LENGTH_SHORT).setView(ToastLayout).setGravity(Gravity.BOTTOM, 0, 0).show()
        -- 未设置头像 / 头像被系统删除 时点击头像的提示
      else
        pic={
          LinearLayout;
          layout_width="fill";
          orientation="vertical";
          {
            ImageView;
            id="img";
            layout_marginTop="16dp";
            layout_height="fill";
            layout_width="fill";
          };
        };

        AlertDialog.Builder(this)
        .setTitle("下载头像？")
        .setView(loadlayout(pic))
        .setPositiveButton("确定",{onClick=function(v)
         下载文件(avatarpic) -- 调用下载器下载头像，使用原生 Lua 时需修改
        end})
        .setNegativeButton("取消",nil)
        .show()
        img.setImageBitmap(loadbitmap(avatarpic))
        -- 点击头像时下载头像提示
      end
    end
  end
end
