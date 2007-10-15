Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A3CCFDE3A9
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 16 Oct 2007 03:17:05 +1000 (EST)
Message-ID: <4713A08C.3060204@freescale.com>
Date: Mon, 15 Oct 2007 12:17:00 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: keng_629 <keng_629@126.com>
Subject: Re: mpc 860 boot linux2.6.23 problem
References: <200710151115352659084@126.com>
In-Reply-To: <200710151115352659084@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

keng_629 wrote:
>  
> i am proting linux2.63.23 to mpc860t board with uboot1.1.4 as bootloader.
> my bootargs is root=/dev/ram rw init=/linuxrc.
> i use debugger to see the regedits, find pc is run in the cpu_idle().
> what is wrong with my kernel, plese give me some advice.thank you .

Posting the same thing over and over again isn't going to change the 
response.  Try head-of-Linus's-git, make sure you're using arch/powerpc, 
and post the device tree you're using.  Without more information, we 
can't help you.

-Scott
