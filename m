Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao04.cox.net (fed1rmmtao04.cox.net [68.230.241.35])
	by ozlabs.org (Postfix) with ESMTP id 73F4667A6D
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 26 Feb 2005 07:31:09 +1100 (EST)
Date: Fri, 25 Feb 2005 13:30:55 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: "Travis B. Sawyer" <tsawyer+linuxppc@sandburst.com>
Message-ID: <20050225133055.A28918@cox.net>
References: <1628E43D99629C46988BE46087A3FBB91C4AA7@ep-01.EmbeddedPlanet.local>
	<421F89A0.8070502@sandburst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <421F89A0.8070502@sandburst.com>;
	from tsawyer+linuxppc@sandburst.com on Fri, Feb 25, 2005 at
	03:25:04PM -0500
Cc: Steven Blakeslee <BlakesleeS@embeddedplanet.com>,
	ppcembed <linuxppc-embedded@ozlabs.org>
Subject: Re: 2.6 4xx GPIO OCP driver?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Feb 25, 2005 at 03:25:04PM -0500, Travis B. Sawyer wrote:
> Steven Blakeslee wrote:
> >>In 2.4 we used the drivers/char/ibm_ocp_gpio.c module.  I see 
> >>no such support in 2.6.10.  I perused the archives, found 
> >>nothing (OBTW: can someone point me to the search engine for 
> >>the list?)
> > 
> > 
> > I see it.  Drivers/char/ibm_gpio.c in Linux 2.6.10-rc3.
> 
> I guess I should be using the linuxppc-2.5 tree instead of straight from
> kernel.org.

I didn't bother merging it upstream at one time. It wasn't clear
if the driver had any value over just mmaping /dev/mem to bang
on the couple gpio registers directly. We can get it in real
2.6 if people really find it more convenient. My only argument
against it is that it's not much of a layer over the trivial
registers and each SoC requires completely different support
since the pin routings are SoC specific.

Anyway, just speak up. ;)

-Matt
