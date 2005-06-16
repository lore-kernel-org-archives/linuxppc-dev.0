Return-Path: <simlo@phys.au.dk>
Received: from lirs02.phys.au.dk (lirs02.phys.au.dk [130.225.28.43])
	by ozlabs.org (Postfix) with ESMTP id 96F93679E7
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Jun 2005 01:24:22 +1000 (EST)
Date: Thu, 16 Jun 2005 17:24:19 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Andrey Volkov <avolkov@varma-el.com>
In-Reply-To: <42B181F3.2090901@varma-el.com>
Message-Id: <Pine.OSF.4.05.10506161721010.24601-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC5200/Lite5200 and ethernet
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 16 Jun 2005, Andrey Volkov wrote:

> Hi Esben
> 
> Esben Nielsen wrote:
> > How do I turn on the in chip FEC ethernet controller in MPC5200 in the
> > stock 2.6.12-rc6 kernel? Do I need an extra patch?
> > 
> take patch here:
> http://ozlabs.org/pipermail/linuxppc-embedded/2005-April/017591.html
> 
> But, since bestcomm still not converted to platform_bus/ppc_sys model,
> it will not be included in vanilla 2.6.12 kernel.
> 

I managed to get something out of the bitkeeper tree referred to from
http://www.246tnt.com/mpc52xx/
It seems to be based on 2.6.10-rc2 right now - good enough for now.

Is that really the latest version now?
What happens when bitkeeper is gone (very soon now, right?)

To whom do I submit patches?

Esben

> -- 
> Regards
> Andrey Volkov
> 
