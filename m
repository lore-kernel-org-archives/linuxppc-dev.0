To: =?gb2312?q?Dross=20Zhou?= <zjuzhou@yahoo.com.cn>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Why can't uncommpress kernel after download s-rec file via tftp? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 22 May 2002 21:59:54 +0800."
             <20020522135954.45659.qmail@web15003.mail.bjs.yahoo.com>
Date: Wed, 22 May 2002 18:16:56 +0200
Message-Id: <20020522161701.22E4E1196F@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Dross Zhou,

in message <20020522135954.45659.qmail@web15003.mail.bjs.yahoo.com> you wrote:
>
> I just added some config option in make menuconfig,
> then make zImage and make s-recorde file.

What is this good for?

TFTP is a binary protocol, it needs a binary image,  not  a  s-record
file.

> Then download this file into sdram vai tftp,it just
> hang at uncompressing kernel image, and can't boot
> kernle.

This is most probably due to the fact that your  firmware  expects  a
binary image but finds a text file.

What sort of firmware are you using anyway?

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
As far as we know, our computer has never had an undetected error.
		                                           -- Weisert

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
