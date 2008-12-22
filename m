Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 05615DDE08
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Dec 2008 08:03:24 +1100 (EST)
Subject: Re: schizophrenic G5 ...
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kevin Diggs <kevdig@hypersurf.com>
In-Reply-To: <494EDB3F.4090604@hypersurf.com>
References: <494EDB3F.4090604@hypersurf.com>
Content-Type: text/plain
Date: Tue, 23 Dec 2008 08:03:15 +1100
Message-Id: <1229979795.4360.18.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2008-12-21 at 16:11 -0800, Kevin Diggs wrote:
> Hi,
> 
> 	I have a water cooled dual 2.5 GHz G5 (Powermac7,3). It has YDL 6.0 on 
> it. Using the stock YDL 2.6.23 kernel this machine "appears" to work fine.
> 
> 	After finally getting it to boot under 2.6.27, it will shut itself off 
> if put under any significant load. And it is doing it very quickly. Like 
> within a few seconds of becoming busy. I just discovered it is spitting 
> out messages about "temperature way above maximum" (from therm_pm72.c).
> 
> 	This one has the Panasonic cooling system. I have checked behind the 
> cover and see no evidence of leaks.
> 
> 	When put under load under the stock YDL kernel, the cpu fans will speed 
> up for about 2 minutes. Then over the next minute or so they will slow 
> down almost to idle. Thereafter a whirring sound can be heard every 15 
> to 30 seconds lasting about 5 seconds. Which I am guessing is the pump? 
> The exhaust air barely gets warm?
> 
> 	Anyone have any ideas? Could the cooling system NOT be correctly 
> thermally connected to the cpus?

I have approx. the same here taking dust under the desk, I'll give it a
spin but i might have to wait a couple of days...

If mine works, then we'll have to run some more intensive debugging to
see what's going on.

Cheers,
Ben.
