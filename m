Return-Path: <jwboyer@jdub.homelinux.org>
Received: from jdub.homelinux.org (67-40-242-100.roch.qwest.net
	[67.40.242.100])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 80A5067B59
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 16 Sep 2006 09:23:53 +1000 (EST)
Subject: Re: ARCH=ppc or ARCH=powerpc
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: Shawn Jin <shawnxjin@gmail.com>
In-Reply-To: <c3d0340b0609151606i2d01b963h4c7cd6a182d8c80@mail.gmail.com>
References: <20060824123841.4756.qmail@web36601.mail.mud.yahoo.com>
	<1156423796.5640.23.camel@zod.rchland.ibm.com>
	<1156424295.19482.11.camel@localhost>
	<20060824132338.GA27468@gate.crashing.org>
	<c3d0340b0609151606i2d01b963h4c7cd6a182d8c80@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 15 Sep 2006 18:23:05 -0500
Message-Id: <1158362585.2622.27.camel@vader.jdub.homelinux.org>
Mime-Version: 1.0
Cc: Matt Porter <mporter@embeddedalley.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 2006-09-15 at 16:06 -0700, Shawn Jin wrote:
> Hi Matt,
> 
> > The goal is to have the new 4xx arch/powerpc support not break 4xx
> > arch/ppc support. So as boards are merged and verified working,
> > we'll remove the equivalent support from arch/ppc...
> >
> > Some boards/chips may just die if no maintainer step up to port
> > them over...but all the important stuff should get an interested
> > party once we get the initial 4xx support in arch/powerpc working.
> 
> When can we expect this done? I have a 440 based SoC project ongoing
> and am thinking when I should start moving to arch/powerpc.

There is no set date or kernel release where this will be done.  In
other words "when it gets done, it gets done". :)

josh
