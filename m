Return-Path: <mike@compulab.co.il>
Received: from alex (62-90-235-247.barak.net.il [62.90.235.247])
	by ozlabs.org (Postfix) with ESMTP id 5F03C679FE
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 18 May 2005 17:19:42 +1000 (EST)
Message-ID: <428AFAB7.4040005@compulab.co.il>
Date: Wed, 18 May 2005 10:20:07 +0200
From: Mike Rapoport <mike@compulab.co.il>
MIME-Version: 1.0
To: Sam Song <samlinuxppc@yahoo.com.cn>
References: <20050518033817.57657.qmail@web15807.mail.cnb.yahoo.com>
In-Reply-To: <20050518033817.57657.qmail@web15807.mail.cnb.yahoo.com>
Content-Type: multipart/alternative;
	boundary="------------040103060901030503060300"
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
--------------040103060901030503060300
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 8bit

Sam Song wrote:

>Mike Rapoport <mike@compulab.co.il> wrote:
>[snip]
>  
>
>>I think you use modutils for 2.4 kernel. In order to
>>work with LKM in 2.6 you need module-init-tools 
>>package.Take a look at
>>
>>    
>>
>http://www.kernel.org/pub/linux/kernel/people/rusty/modules/
>
>Thanks. I downloaded the newest package. Then where 
>should I apply it? For kernel source or ELDK? I read 
>FAQ but no clear clue on it!
>
>  
>
I'm not familiar with ELDK, but I suppose it creates filesystem for the
target. The module-init-tools package should be installed on this
filesystem.

>Thanks again,
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
>
>
>
>  
>


-- 
Sincerely yours,
Mike 


--------------040103060901030503060300
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
 cite="mid20050518033817.57657.qmail@web15807.mail.cnb.yahoo.com"
 type="cite">
  <pre wrap="">Mike Rapoport <a class="moz-txt-link-rfc2396E" href="mailto:mike@compulab.co.il">&lt;mike@compulab.co.il&gt;</a> wrote:
[snip]
  </pre>
  <blockquote type="cite">
    <pre wrap="">I think you use modutils for 2.4 kernel. In order to
work with LKM in 2.6 you need module-init-tools 
package.Take a look at

    </pre>
  </blockquote>
  <pre wrap=""><!----><a class="moz-txt-link-freetext" href="http://www.kernel.org/pub/linux/kernel/people/rusty/modules/">http://www.kernel.org/pub/linux/kernel/people/rusty/modules/</a>

Thanks. I downloaded the newest package. Then where 
should I apply it? For kernel source or ELDK? I read 
FAQ but no clear clue on it!

  </pre>
</blockquote>
I'm not familiar with ELDK, but I suppose it creates filesystem for the
target. The module-init-tools package should be installed on this
filesystem.<br>
<blockquote
 cite="mid20050518033817.57657.qmail@web15807.mail.cnb.yahoo.com"
 type="cite">
  <pre wrap="">Thanks again,

Sam

_________________________________________________________
Do You Yahoo!?
150万曲MP3疯狂搜，带您闯入音乐殿堂
<a class="moz-txt-link-freetext" href="http://music.yisou.com/">http://music.yisou.com/</a>
美女明星应有尽有，搜遍美图、艳图和酷图
<a class="moz-txt-link-freetext" href="http://image.yisou.com">http://image.yisou.com</a>
1G就是1000兆，雅虎电邮自助扩容！
<a class="moz-txt-link-freetext" href="http://cn.rd.yahoo.com/mail_cn/tag/1g/*http://cn.mail.yahoo.com/event/mail_1g/">http://cn.rd.yahoo.com/mail_cn/tag/1g/*http://cn.mail.yahoo.com/event/mail_1g/</a>



  </pre>
</blockquote>
<br>
<br>
<pre class="moz-signature" cols="72">-- 
Sincerely yours,
Mike 
</pre>
</body>
</html>

--------------040103060901030503060300--
