Return-Path: <jolt@tuxbox.org>
Received: from fiebig.biz (loadbalancer1.core.taytron.net [80.190.249.152])
	by ozlabs.org (Postfix) with ESMTP id 9818A68725
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Nov 2005 22:47:26 +1100 (EST)
Message-ID: <437B1C53.1060004@tuxbox.org>
Date: Wed, 16 Nov 2005 12:47:31 +0100
From: Florian Schirmer <jolt@tuxbox.org>
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
References: <20051114143821.GA28852@logos.cnet> <43798327.70305@tuxbox.org>
	<20051115054216.GB29963@logos.cnet>
	<20051115142147.GD32373@logos.cnet>
In-Reply-To: <20051115142147.GD32373@logos.cnet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: obi@saftware.de, carjay@gmx.de,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] m8xx_wdt: software watchdog reset/interrupt select
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

>> The SYPCR register can be set only _once_ at machine startup and the
>> bootloader in question does not have an option to change the mode. Many
>> bootloaders probably dont.

Okay, i was asuming you have control over the bootloader.

> Updated patch addresses code duplication issue you mentioned and also 
> adds an error message in case timer interrupt frequency is higher
> than the watchdog frequency.
> 
> Can I add your Signed-off-by in case you're OK with it?

Maybe i'm missing something obvious, but why is the interrupt driven 
reaming code not working for your configuration. Are you using the PIT 
for something else?

Otherwise i'm fine with the patch. Feel free to add my Signed-off-by line.

Best,
   Florian
