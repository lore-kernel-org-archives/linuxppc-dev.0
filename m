Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B88D4B7D18
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  2 Apr 2010 09:49:31 +1100 (EST)
Subject: Re: poweroff/suspend problems on PowerMac G5
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Vorontsov <cbouatmailru@gmail.com>
In-Reply-To: <20100401151450.GA26399@oksana.dev.rtsoft.ru>
References: <alpine.DEB.2.01.1003310430570.5493@bogon.housecafe.de>
	<20100331132300.GA15951@oksana.dev.rtsoft.ru>
	<alpine.DEB.2.01.1003311131250.5493@bogon.housecafe.de>
	<20100401145642.70d5eab0.krautilein@gmx.de>
	<20100401151450.GA26399@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 02 Apr 2010 09:49:20 +1100
Message-ID: <1270162160.7101.136.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Bolko Maass <krautilein@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-04-01 at 19:14 +0400, Anton Vorontsov wrote:

> So CONFIG_HIBERNATION breaks suspend? Hm. How do you try
> to suspend? echo mem > /sys/power/state?

Nah, suspend isn't supported on these ( ... yet, I suppose I could
implement it one of these days if nouveau can bring back the video
card).

I think his problem is that CONFIG_HIB* is breaking shutdown.

> > as well as when just trying to shut
> > down the machine.
> 
> How do try to shut down the machine? halt/poweroff commands?
> 
> >From a brief look, I don't see how CONFIG_HIBERNATION may change
> halt/poweroff code flow in the kernel...
> 
> Can you show us a boot log of working and not working kernels?
> And .config files you use.
> 
> ..maybe for some reason PMU/SMU modules didn't get loaded?

Nah, I doubt it. Smells more like the old crap with broken cpu unplug on
shutdown, no ?

I have one of these guys at work, I can give it a try next week.

Cheers,
Ben.
