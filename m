Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A68EEDDEDE
	for <linuxppc-dev@ozlabs.org>; Sat, 19 May 2007 04:30:39 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l4IIUYxs023113
	for <linuxppc-dev@ozlabs.org>; Fri, 18 May 2007 11:30:34 -0700 (MST)
Message-ID: <464DF0A9.1020706@freescale.com>
Date: Fri, 18 May 2007 13:30:01 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH 5/5] PCI fixes for the MPC8641 Rev 2.0 silicon and Rev
	1.02hardware
References: <1179245829.8132.100.camel@rhino>	
	<1179247809.8132.138.camel@rhino>	
	<46B96294322F7D458F9648B60E15112C23441B@zch01exm26.fsl.freescale.net>	
	<1179417813.8132.250.camel@rhino>	
	<744CD970-5421-47D6-A30A-C7C79BE21BE8@kernel.crashing.org>	
	<1179421139.8132.256.camel@rhino> <464CA302.9060707@freescale.com>	
	<20070518005641.GA27350@localhost.localdomain>	
	<464DB986.20205@freescale.com>	
	<20070518164628.GA16825@ld0162-tx32.am.freescale.net>	
	<464DE2D3.3090805@smiths-aerospace.com>
	<464DE4C7.7030906@freescale.com>	 <464DE5D2.5000301@freescale.com>
	<464DE6C1.2010108@freescale.com>	 <464DE7F7.3030302@freescale.com>
	<464DE8BB.5040601@freescale.com>
	<1179512385.19664.8.camel@ld0161-tx32>
In-Reply-To: <1179512385.19664.8.camel@ld0161-tx32>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Wei Zhang <Wei.Zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Loeliger wrote:

>> I think my model (which is also Jon's, I think) is easier to read and implement.
> 
> Harumph.

Hey, I got the idea from you!

> First of all, I wanted to get away from the notion of calling
> anything a "jumper".  What I said to you was to predicate the
> clause based on some arbitrary conditional, not just some "jumper
> setting."

True, but the arbitrary condition would, in practice, be the value of some 
jum^H^H^Hhardware setting.

> Second, I never came anywhere near the syntax above.

That's just a rough version because I don't have the DTS layout memorized.

> Third, I am pretty sure we've always really been talking
> about a DTC enhancement to selectively add regions to the
> DTB in much the same way as if one had said:

The problem is that the conditions that I'm talking about are not known until U-Boot runs. 
  If your idea was only compile-time conditional, then I'm just extending it to a runtime 
conditional.

> So embedding a full runtime evaluation of conditionals
> expressions wasn't really in my suggestion at this time
> at all.  I had essentially proposed (to you, Timur) that
> we have a predicate clause in the DTS that guarded a the
> presence/absence of a node.

predicate clause == conditional.

> And finally, I wasn't sure I was happy with it all yet
> in any event, so I hadn't acted on it yet.  I was still
> pondering "the right approach here".

I was trying to avoid a premature discussion on this idea, but apparently everyone else 
wants to talk about it!

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
