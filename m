Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DC1F6DDF5C
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Feb 2008 07:51:37 +1100 (EST)
Message-ID: <47B4A9D7.3030100@freescale.com>
Date: Thu, 14 Feb 2008 14:51:35 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Leon Woestenberg <leon.woestenberg@gmail.com>
Subject: Re: High resolution timer support in 2.6.24+ for MPC831x?
References: <c384c5ea0802141226m630fcc11h60627cde75cb8b0e@mail.gmail.com>
In-Reply-To: <c384c5ea0802141226m630fcc11h60627cde75cb8b0e@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Leon Woestenberg wrote:
> Hello all,
> 
> although I can enable high res timers in 2.6.24, the item note says it
> does nothing if the platform does not have support for it.
> 
> My platform is a MPC8313E-RDB, and I suspect no high res clock source
> implementation exists for it in 2.6.24, because
> clock_getres(CLOCK_REALTIME,) gives me 1/HZ.
> 
> Is this correct and/or is anything in the works?

The timebase/decrementer can be used as a high clock source on virtually 
all powerpc chips; I tried clock_getres(CLOCK_REALTIME) on an 8313erdb, 
and I got 1 ns.  Did you turn on CONFIG_HIGH_RES_TIMERS?

-Scott
