To: weiwu <weiwu@isdn.iscas.ac.cn>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: sorry!Another question about flash! 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 06 Sep 2001 18:17:53 +0800."
             <200109061016.SAA00658@isdn.iscas.ac.cn>
Date: Thu, 06 Sep 2001 13:05:42 +0200
Message-Id: <20010906110547.D648010CC5@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <200109061016.SAA00658@isdn.iscas.ac.cn> you wrote:
>
> 1.who have block device driver of flash?  And can I share with you?
>  (Intel 28F320J5(4MBytes, 8bit) flash memory)

See the MTD stuff that comes with your kernel sources.

> 2.The "ftl or mtd" is only for PCMCIA?

MTD is not only for PCMCIA.

> Can we use it in the general flash board ?such as ppc mother board!

Yes.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
        ... Hiroshima 45 ... Chernobyl 86 ... Windows 95 ...

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
