Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B8C6BDDE1E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 Oct 2007 02:18:37 +1000 (EST)
Message-ID: <4714E44F.7030909@freescale.com>
Date: Tue, 16 Oct 2007 11:18:23 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Subject: Re: mpc 860 boot linux2.6.23 problem
References: <20071015233839.959F4247BB@gemini.denx.de>
In-Reply-To: <20071015233839.959F4247BB@gemini.denx.de>
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

Wolfgang Denk wrote:
> In message <4713A08C.3060204@freescale.com> you wrote:
>> keng_629 wrote:
>>>  
>>> i am proting linux2.63.23 to mpc860t board with uboot1.1.4 as bootloader.
>>> my bootargs is root=/dev/ram rw init=/linuxrc.
>>> i use debugger to see the regedits, find pc is run in the cpu_idle().
>>> what is wrong with my kernel, plese give me some advice.thank you .
>> Posting the same thing over and over again isn't going to change the 
>> response.  Try head-of-Linus's-git, make sure you're using arch/powerpc, 
>> and post the device tree you're using.  Without more information, we 
>> can't help you.
> 
> Just to point out the obvious: U-Boot 1.1.4 is *way* too old to
> support any device-tree based kernel, so the fist step is to update
> U-Boot to a somewhat recent version (i. e. 1.3.0-rcX).

Upgrading to the latest u-boot certainly shouldn't hurt, but I don't 
think there's any device tree support for 8xx yet, so for now he should 
boot with cuImage.

-Scott
