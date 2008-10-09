Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6F775DDF7B
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 20:26:11 +1100 (EST)
Message-ID: <48EE3A9D.5040007@freescale.com>
Date: Thu, 09 Oct 2008 12:08:45 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: [PATCH] powerpc: remove default=y from PMAC and CHRP Kconfigs
References: <1223495845-14149-1-git-send-email-timur@freescale.com>		<1223496186.8157.82.camel@pasglop>		<ed82fe3e0810081314g34b902f7j76f5049faf91f905@mail.gmail.com>		<1223498380.8157.86.camel@pasglop>	<48ED1B9E.3020907@freescale.com>	
	<48EE2A49.10405@genesi-usa.com>	<ed82fe3e0810090920t25442258gcd5cedabf686fe2d@mail.gmail.com>
	<48EE3636.7020305@genesi-usa.com>
In-Reply-To: <48EE3636.7020305@genesi-usa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Matt Sealey wrote:
>> CHRP and PMAC aren't following the rules that everyone else is 
>> following.  Why?
> 
> Because they are by far the historically most common configuration, and
> still in production as the defacto standard PowerPC system configuration.

So you could make an argument for it being turned on in 
arch/powerpc/defconfig, if we had one.  That doesn't mean it should be 
"default y".

> IBM blades etc. with SLOF will boot up as a CHRP-ish system, as well as the
> Efika and Pegasos and anything else Genesi produces. Since Linux 
> distributions
> generally do not support tiny embedded boards,

What do distributions have to do with it?  It's harder for distributions 
to set the options they want than for embedded developers?

> you can imagine why it's
> disabled by default, but there's no reason it can't be ENABLED by default
> and turned off by a distribution, the same way it can't be enabled by
> default and turned off by YOU (compare and contrast having to manually
> select which board you want to build for every time).

Likewise there's no reason that PMAC/CHRP can't be DISABLED by default, 
and turned on by YOU.

> But, turning them all on would not matter. You would build a kernel for
> every one and a device tree for every one increasing your build time a
> bit for a default kernel,

s/a bit/a lot/

> but you would be guaranteed to get a kernel
> binary somewhere in the tree that would work on all of them :)

Really?  Who do I go to for this guarantee, when there's no support for 
the hardware I'm trying to get to work? :-)

-Scott
