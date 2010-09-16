Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 931841007D8
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Sep 2010 08:04:00 +1000 (EST)
Subject: Re: linux support for freescale e5500 core?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Chris Friesen <chris.friesen@genband.com>
In-Reply-To: <4C928FC5.9050700@genband.com>
References: <4C9278CD.10607@genband.com>
	<20100916163911.6255d359@schlenkerla.am.freescale.net>
	<4C928FC5.9050700@genband.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 17 Sep 2010 08:03:48 +1000
Message-ID: <1284674628.30449.98.camel@pasglop>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	paulus@samba.org, timur@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-09-16 at 15:44 -0600, Chris Friesen wrote:
> On 09/16/2010 03:39 PM, Scott Wood wrote:
> > On Thu, 16 Sep 2010 14:06:37 -0600
> > Chris Friesen <chris.friesen@genband.com> wrote:
> > 
> >> We're looking at maybe doing some work with an e5500-based system.  Is
> >> there any support existing/planned for this core?
> > 
> > Check with whoever you'd be getting the hardware from about a BSP.
> > 
> > And yes, it should be supported upstream at some point.
> 
> We haven't settled on a vendor yet, so I was just wondering in general
> what the story was around support.

Well, the "core" support for 64-bit BookE is upstream (and has been for
a little while) so +/- specific tweaks FSL may have done and the usual
SoC/board support, it shouldn't be too far off.

> Right.  We currently use a 970-series cpu and have implemented a
> per-process flag to indicate whether 32-byte mode is needed or not.
> We'd have to do something similar with the new cpu.

Sounds like a candidate for upstreaming the patch :-)

> One last question--can you comment on the speed of an e5500 relative to
> a 970 for integer operations?

Cheers,
Ben.
