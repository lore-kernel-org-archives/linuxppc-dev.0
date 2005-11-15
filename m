Return-Path: <jolt@tuxbox.org>
Received: from fiebig.biz (loadbalancer1.core.taytron.net [80.190.249.152])
	by ozlabs.org (Postfix) with ESMTP id 4099368776
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Nov 2005 17:26:28 +1100 (EST)
Message-ID: <43797C29.3000605@tuxbox.org>
Date: Tue, 15 Nov 2005 07:11:53 +0100
From: Florian Schirmer <jolt@tuxbox.org>
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
References: <20051114143821.GA28852@logos.cnet>
	<9E7D3814-47AB-4601-A565-2530C3A4BEE0@kernel.crashing.org>
	<20051114155736.GB29411@logos.cnet>
	<20051114160302.GC29411@logos.cnet>
In-Reply-To: <20051114160302.GC29411@logos.cnet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: obi@saftware.de, carjay@gmx.de,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] m8xx_wdt: software watchdog reset/interrupt select\
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

> Actually, drivers/char/watchdog/mpc8xx_wdt.c is a module, while
> some of the initialization code must reside in the kernel image.
> 
> Thats the reason for the split - not sure if merging the two
> files is worth?

If you have a short timeout (like the 2 secs we had) then you need to 
have the handler ready long before the module could be loaded.

Best,
   Florian
