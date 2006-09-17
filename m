Return-Path: <dhlii@dlasys.net>
Received: from mx.dlasys.net (24.152.213.223.res-cmts.eph.ptd.net
	[24.152.213.223]) by ozlabs.org (Postfix) with ESMTP id 31F4567B78
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 17 Sep 2006 23:30:29 +1000 (EST)
Message-ID: <450D4AC2.2090503@dlasys.net>
Date: Sun, 17 Sep 2006 09:16:50 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: wei.li4@elf.mcgill.ca
Subject: Re: Kernel Blocked
References: <20060915155139.3u0q0lb5s0g0ww0s@webmail.mcgill.ca>
In-Reply-To: <20060915155139.3u0q0lb5s0g0ww0s@webmail.mcgill.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

    I have a Xilinx ppc405 working out of the 2.6.18-rc7 linux-2.6 git 
tree - with patches for my board.
   
    I beleive you are either just at the end of the code in 
arch/ppc/boot/simple - which is mostly the initial load/decompress.
    Or just started the code in arch/ppc/kernel/head_4xx.S

    You ought to be able to grep "Now booting" to establish a last know 
good point.
    There is also a pretty good call tree in comments of 
arch/ppc/platforms/4xx/xilinx_ml403.c.
    While small parts are ml403 specific, much of it is generic.
    However, if you have not gotten into arch/ppc/kernel/head_4xx.S then 
you are not at the begining yet.
   


wei.li4@elf.mcgill.ca wrote:
> Hi All,
>
> First, if anyone wants to use linux 2.6.18-rc2-g73a589b5 with ppc, he 
> should patch inflate.c from linux 2.6.18-rc7 to fix Uncompressing 
> failure problem. But new problem is: when relocate and gunzip functions 
> are finished, and 'Now booting the kernel' is shown, the system is 
> halted. My bootloader is working fine with linux 2.6.13, could anyone 
> tell me what the next function executes and how to check this kind of 
> problem, thanks.
>
> Wei
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>   


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
