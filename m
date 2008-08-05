Return-Path: <marco.stornelli@coritel.it>
Received: from nausicaa2.coritel.it
	(host254-130-static.190-82-b.business.telecomitalia.it
	[82.190.130.254]) by ozlabs.org (Postfix) with ESMTP id 7D087DE17E
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  5 Aug 2008 23:20:17 +1000 (EST)
Message-ID: <4898540C.2060105@coritel.it>
Date: Tue, 05 Aug 2008 15:22:20 +0200
From: Marco Stornelli <marco.stornelli@coritel.it>
MIME-Version: 1.0
To: Zhivko Yordanov <jivkojj@uni-kassel.de>
Subject: Re: Run Linux Kernel 2.6.26 with u-boot 1.1.2 - problem
References: <200808051109.20398.jivkojj@uni-kassel.de>
In-Reply-To: <200808051109.20398.jivkojj@uni-kassel.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Zhivko Yordanov ha scritto:
> Hi all,
> 
> I have a PowerPC embedded board with CPU 7448 and Chipset Marvell 64560.
> Till now, on board runs U-boot 1.1.2 and Linux kernel 2.6.12, with patches 
> from Marvell.
> 
> I ported the Marvell patch to Linux 2.6.26, but I can't start it. Now I'm 
> searching for the problem. Is this possible with old u-boot (1.1.2) to start 
> new versions of Linux kernel, or I need to port u-boot too?
> 
> Best regards,
> Zhivko Yordanov
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 

Have you wrote the dts file? I suggest you to change Uboot, 1.1.2 is 
pretty old and if I remember correctly it doesn't support the dts, so 
you should build a cuImage with the dts embedded in the kernel.

-- 
Marco Stornelli
Embedded Software Engineer
CoRiTeL - Consorzio di Ricerca sulle Telecomunicazioni
http://www.coritel.it

marco.stornelli@coritel.it
+39 06 72582838
