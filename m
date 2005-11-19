Return-Path: <jolt@tuxbox.org>
Received: from fiebig.biz (loadbalancer1.core.taytron.net [80.190.249.152])
	by ozlabs.org (Postfix) with ESMTP id 4EA78681C2
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 19 Nov 2005 17:16:31 +1100 (EST)
Message-ID: <437EC340.6020702@tuxbox.org>
Date: Sat, 19 Nov 2005 07:16:32 +0100
From: Florian Schirmer <jolt@tuxbox.org>
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
References: <20051114143821.GA28852@logos.cnet> <43798327.70305@tuxbox.org>
	<20051115054216.GB29963@logos.cnet>
	<20051115142147.GD32373@logos.cnet> <437B1C53.1060004@tuxbox.org>
	<20051116083609.GC4441@logos.cnet> <437C499C.6090002@tuxbox.org>
	<20051118153657.GA13943@logos.cnet>
In-Reply-To: <20051118153657.GA13943@logos.cnet>
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

> After your message I decided to check if the PIT is working, guess what: it isnt.
> 
> Our board uses an external RTC (the internal RTC/PIT HW seem to be
> nonexistant/nonfunctional).

Now it starts to make sense :-) Patch looks good. If Dan doesn't come up 
with a better idea to solve the clock detection problem feel free to go 
ahead and send it upstream.

Best,
   Florian
