Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0303067B97
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Sep 2006 09:31:04 +1000 (EST)
Subject: Re: [Fwd: Re: ohci1394: steps to implement suspend/resume]
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
In-Reply-To: <4500743D.9000403@s5r6.in-berlin.de>
References: <44FEDF5D.9060707@s5r6.in-berlin.de>
	<1157590416.22705.269.camel@localhost.localdomain>
	<4500743D.9000403@s5r6.in-berlin.de>
Content-Type: text/plain
Date: Fri, 08 Sep 2006 09:30:41 +1000
Message-Id: <1157671842.22705.340.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux1394-devel@lists.sourceforge.net,
	Bernhard Kaindl <bk@fsfe.org>, Pavel Machek <pavel@ucw.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-09-07 at 21:34 +0200, Stefan Richter wrote:
> Benjamin Herrenschmidt wrote:
> > On Wed, 2006-09-06 at 16:46 +0200, Stefan Richter wrote:
> [...]
> >> We already broke your platform code once by what was meant as a bugfix
> >> for non-PMacs. It'd be good to know enough to not repeat such mistakes...
> > 
> > The PowerMac code will stop the chip clocks. It should be used as the
> > last step of the suspend sequence and first step of the return sequence,
> > in _addition_ to your new code.
> 
> Thanks for the help.

np. I'll try to test if I find some time :)

Ben.
