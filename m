Return-Path: <xchen@sunrisetelecom.com.cn>
Received: from smtp01.east.net (smtp01.east.net [211.100.61.140])
	by ozlabs.org (Postfix) with ESMTP id 1749067A2E
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Dec 2006 12:33:12 +1100 (EST)
From: =?gb2312?B?s8LPow==?= <xchen@sunrisetelecom.com.cn>
To: "'enorm'" <enorm@126.com>, <linuxppc-embedded@ozlabs.org>,
	<linuxppc-embedded-request@ozlabs.org>
Subject: Re: When I use ichache_enable or dcache_enable in uboot,it crash
Date: Fri, 8 Dec 2006 09:33:16 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
In-Reply-To: <001501c719fa$19e45020$8809a8c0@class>
Message-Id: <20061208013328.1749067A2E@ozlabs.org>
Cc: 'Elvis Ma' <npma@sunrisetelecom.com.cn>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

 Hi enorm

	Thank you for your reply. In fact, the uboot has never disable
icache. The icache is enable at all times.And the code run in flash =
normally
when the icache is enable.  I have to add disable_icache() in the
board_init_f() so that the code can run in ram normally.  BTW, I just =
use
the function supported by uboot to enable icache&dcache, I'm sure the =
steps
of cache init have no problem. I just can't understand why the icache =
can
effect the code run in ram.

Thanks &Br,
Andy

-----=D3=CA=BC=FE=D4=AD=BC=FE-----
=B7=A2=BC=FE=C8=CB: enorm [mailto:enorm@126.com]=20
=B7=A2=CB=CD=CA=B1=BC=E4: 2006=C4=EA12=D4=C27=C8=D5 20:21
=CA=D5=BC=FE=C8=CB: =B3=C2=CF=A3; linuxppc-embedded@ozlabs.org;
linuxppc-embedded-request@ozlabs.org
=D6=F7=CC=E2: (Rising Spam Alert)Re: When I use ichache_enable or =
dcache_enable in
uboot,it crash

disable icache& dcache at the beginning is essential or else your =
program
will crash. Only when you do the proper initiation, can you enable them. =
For
details you can refer to you reference manual.


----- Original Message -----
From: "=B3=C2=CF=A3" <xchen@sunrisetelecom.com.cn>
To: <linuxppc-embedded@ozlabs.org>; =
<linuxppc-embedded-request@ozlabs.org>
Sent: Thursday, December 07, 2006 5:52 PM
Subject: When I use ichache_enable or dcache_enable in uboot,it crash


> Hi,
>
> In the very begin of the uboot, the dcache is disable and the icache
> is enable. The code runs in flash nomarlly. Then the uboot should jump =
to
> ram and if I don't  disable icache the uboot will crash. I can't =
enable=20
> the
> dcache too. The more serious problem is that when I boot the linux =
kernel
> ,it will stop at init_mmu. I think it is the same reason. Please help =
me.
>
> Thanks & Br,
> Andy
>
>


-------------------------------------------------------------------------=
---
----


> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded=20
