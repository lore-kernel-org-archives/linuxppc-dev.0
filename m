Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B09A5DDE9D
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2007 09:57:35 +1000 (EST)
Subject: Re: [PATCH] Re: 2.6.22-git hangs during boot on PowerBook G3 in
	0.0 seconds
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kim Phillips <kim.phillips@freescale.com>
In-Reply-To: <20070723172725.b1c14885.kim.phillips@freescale.com>
References: <20070721192143.GA12144@nospam.com>
	<20070721212845.GA30977@nospam.com>
	<20070723172725.b1c14885.kim.phillips@freescale.com>
Content-Type: text/plain
Date: Tue, 24 Jul 2007 09:55:23 +1000
Message-Id: <1185234923.5439.158.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Rutger Nijlunsing <rutger@nospam.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > After hours of fun git bisecting, finally found the commit to revert
> > to make my PowerBook G3 Lombard boot again. This does not result in
> > the complains the reverted commit was revering to.
> 
> ..but it does on my MPC8360.

In which circumstances are you trying to translate an address with no
size cell ?

I also wonder why it hangs on the powerbook... Rutger, I would expect to
see that complaint warning with the reverted patch, what does it say ?

My Wallstreet (also based on Grackle) doesn't have the problem. Also can
you send me a tarball of /proc/device-tree ?

Cheers,
Ben.
