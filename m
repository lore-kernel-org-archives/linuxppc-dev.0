To: "zhongqx" <zhongqx@guoguang.com.cn>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Where can i get LSP for PPC(860T)? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 09 Jul 2002 14:20:04 +0800."
             <001501c22710$ab42b1b0$7301a8c0@zhongqx>
Date: Tue, 09 Jul 2002 18:56:03 +0200
Message-Id: <20020709165608.C50581086F@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <001501c22710$ab42b1b0$7301a8c0@zhongqx> you wrote:
>
>     I use linux kernel 2.4.18 and simple ramdisk.image.gz which only
> contain one binary tool "ls" ,now I want to config net and make a
> programs for this platform.but where can i got other binary tools like "route",
> "ifconfig" and libary which "printf" needed, I search for this,some
> one said,that Movtonvista has LSP for 8xx cpu ,but I can not download it,Can anyone tell me where can i get it?
> thank you very much in advanced!

You  can  download  our  ELDK,  which  is  a   complete   development
environment (both cross and native tools); see
http://www.denx.de/ELDK/

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
To the systems programmer,  users  and  applications  serve  only  to
provide a test load.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
