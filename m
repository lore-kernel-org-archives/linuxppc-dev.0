Return-Path: <mike@compulab.co.il>
Received: from alex (62-90-235-247.barak.net.il [62.90.235.247])
	by ozlabs.org (Postfix) with ESMTP id 22831679F3
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 16 May 2005 23:13:33 +1000 (EST)
Message-ID: <4288AAA7.9050205@compulab.co.il>
Date: Mon, 16 May 2005 16:13:59 +0200
From: Mike Rapoport <mike@compulab.co.il>
MIME-Version: 1.0
To: Sam Song <samlinuxppc@yahoo.com.cn>
References: <20050516125932.71078.qmail@web15802.mail.cnb.yahoo.com>
In-Reply-To: <20050516125932.71078.qmail@web15802.mail.cnb.yahoo.com>
Content-Type: multipart/alternative;
	boundary="------------040004000207030906090407"
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: 2.6.x insmod problem on 82xx platform
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------040004000207030906090407
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 8bit

Sam Song wrote:

>Hi all,
>
>I met a strange problem when trying to insmod a 
>extern module in 2.6.12-rc2 on a MPC8241 board.
>Even lsmod didn't work. Following is the error
>message working on ELDK3.0. 
>
>bash-2.05b# insmod mymodule.o
>insmod: QM_MODULES: Function not implemented
>
>bash-2.05b# lsmod
>Module                  Size  Used by
>lsmod: QM_MODULES: Function not implemented
>
>  
>
I think you use modutils for 2.4 kernel. In order to work with LKM in
2.6 you need module-init-tools package.
Take a look at http://www.kernel.org/pub/linux/kernel/people/rusty/modules/

>I greped QM_MODULES in the kernel source code
>but found nothing. What's happening to LKM in
>2.6.x? 
>
>Don't tell me that LKM hasn't been supported
>yet in 2.6.x:-)
>
>Thanks in advance,
>
>Sam
>
>_________________________________________________________
>Do You Yahoo!?
>150万曲MP3疯狂搜，带您闯入音乐殿堂
>http://music.yisou.com/
>美女明星应有尽有，搜遍美图、艳图和酷图
>http://image.yisou.com
>1G就是1000兆，雅虎电邮自助扩容！
>http://cn.rd.yahoo.com/mail_cn/tag/1g/*http://cn.mail.yahoo.com/event/mail_1g/
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>
>
>  
>
-- 

Sincerely yours,
Mike


--------------040004000207030906090407
Content-Type: text/html; charset=GB2312
Content-Transfer-Encoding: 8bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=GB2312" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Sam Song wrote:
<blockquote
 cite="mid20050516125932.71078.qmail@web15802.mail.cnb.yahoo.com"
 type="cite">
  <pre wrap="">Hi all,

I met a strange problem when trying to insmod a 
extern module in 2.6.12-rc2 on a MPC8241 board.
Even lsmod didn't work. Following is the error
message working on ELDK3.0. 

bash-2.05b# insmod mymodule.o
insmod: QM_MODULES: Function not implemented

bash-2.05b# lsmod
Module                  Size  Used by
lsmod: QM_MODULES: Function not implemented

  </pre>
</blockquote>
I think you use modutils for 2.4 kernel. In order to work with LKM in
2.6&nbsp; you need module-init-tools package.<br>
Take a look at&nbsp;<a
 href="http://www.kernel.org/pub/linux/kernel/people/rusty/modules/">
http://www.kernel.org/pub/linux/kernel/people/rusty/modules/</a><br>
<blockquote
 cite="mid20050516125932.71078.qmail@web15802.mail.cnb.yahoo.com"
 type="cite">
  <pre wrap="">I greped QM_MODULES in the kernel source code
but found nothing. What's happening to LKM in
2.6.x? 

Don't tell me that LKM hasn't been supported
yet in 2.6.x:-)

Thanks in advance,

Sam

_________________________________________________________
Do You Yahoo!?
150万曲MP3疯狂搜，带您闯入音乐殿堂
<a class="moz-txt-link-freetext" href="http://music.yisou.com/">http://music.yisou.com/</a>
美女明星应有尽有，搜遍美图、艳图和酷图
<a class="moz-txt-link-freetext" href="http://image.yisou.com">http://image.yisou.com</a>
1G就是1000兆，雅虎电邮自助扩容！
<a class="moz-txt-link-freetext" href="http://cn.rd.yahoo.com/mail_cn/tag/1g/*http://cn.mail.yahoo.com/event/mail_1g/">http://cn.rd.yahoo.com/mail_cn/tag/1g/*http://cn.mail.yahoo.com/event/mail_1g/</a>
_______________________________________________
Linuxppc-embedded mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a>
<a class="moz-txt-link-freetext" href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a>



  </pre>
</blockquote>
-- <br>
<pre class="moz-signature" cols="72">Sincerely yours,
Mike
</pre>
</body>
</html>

--------------040004000207030906090407--
