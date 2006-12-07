Return-Path: <enorm@126.com>
Message-ID: <001501c719fa$19e45020$8809a8c0@class>
From: "enorm" <enorm@126.com>
To: =?gb2312?B?s8LPow==?= <xchen@sunrisetelecom.com.cn>,
	<linuxppc-embedded@ozlabs.org>, <linuxppc-embedded-request@ozlabs.org>
References: <20061207095910.AD77667BB2@ozlabs.org>
Subject: Re: When I use ichache_enable or dcache_enable in uboot,it crash
Date: Thu, 7 Dec 2006 20:20:36 +0800
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="gb2312"; reply-type=original
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

disable icache& dcache at the beginning is essential or else your program 
will crash. Only when you do the proper initiation, can you enable them. For 
details you can refer to you reference manual.


----- Original Message ----- 
From: "³ÂÏ£" <xchen@sunrisetelecom.com.cn>
To: <linuxppc-embedded@ozlabs.org>; <linuxppc-embedded-request@ozlabs.org>
Sent: Thursday, December 07, 2006 5:52 PM
Subject: When I use ichache_enable or dcache_enable in uboot,it crash


> Hi,
>
> In the very begin of the uboot, the dcache is disable and the icache
> is enable. The code runs in flash nomarlly. Then the uboot should jump to
> ram and if I don't  disable icache the uboot will crash. I can't enable 
> the
> dcache too. The more serious problem is that when I boot the linux kernel
> ,it will stop at init_mmu. I think it is the same reason. Please help me.
>
> Thanks & Br,
> Andy
>
>


--------------------------------------------------------------------------------


> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded 
