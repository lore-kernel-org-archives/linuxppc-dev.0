Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DE940DDE38
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Mar 2007 05:59:22 +1000 (EST)
Subject: Re: more bogomips :)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christian Kujau <lists@nerdbynature.de>
In-Reply-To: <Pine.LNX.4.64.0703241645360.10654@sheep.housecafe.de>
References: <Pine.LNX.4.64.0703241645360.10654@sheep.housecafe.de>
Content-Type: text/plain
Date: Sun, 25 Mar 2007 05:59:13 +1000
Message-Id: <1174766353.10836.104.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2007-03-24 at 16:48 +0000, Christian Kujau wrote:
> I know bogomips are kinda "bogus by definition", but I'll ask anyway, 
> out of curiosity:
> 
> --- ppc-cpuinfo.2.6.20-rc6      2007-01-27 12:33:00.000000000 +0000
> +++ ppc-cpuinfo.2.6.21-rc4-git6 2007-03-24 16:25:26.000000000 +0000
> @@ -1,8 +1,8 @@
>   processor      : 0
>   cpu            : 7447A, altivec supported
> -clock          : 1199.999997MHz
> +clock          : 1199.999000MHz
>   revision       : 0.1 (pvr 8003 0101)
> -bogomips       : 36.73
> +bogomips       : 73.47
>   timebase       : 18432000
>   platform       : PowerMac
>   machine                : PowerBook6,5
> 
> It seems that with a more recent kernel, bogomips have doubled (both 
> with CONFIG_HZ=1000, if this matters). How comes?

Not sure what the bogomips are about nowadays but they are irrelevant on
most macs as we use the timebase for short delays.

Ben.
 
