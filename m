Return-Path: <kim.phillips@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 697D1DDE1E
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Aug 2007 07:31:52 +1000 (EST)
Date: Mon, 6 Aug 2007 16:31:37 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC][PATCH] MPC832x_RDB: update dts to use spi, register
	mmc_spi stub
Message-Id: <20070806163137.136cc689.kim.phillips@freescale.com>
In-Reply-To: <5e9344956c9e6d81f75d14d67064b78e@kernel.crashing.org>
References: <20070726135738.GB5643@localhost.localdomain>
	<7BACDD73-9097-4139-8331-A1A14A6134D0@kernel.crashing.org>
	<20070727114559.GB11463@localhost.localdomain>
	<b3d36996792216ddd9dbae12212a4168@kernel.crashing.org>
	<20070801141614.ad6604bb.kim.phillips@freescale.com>
	<5e9344956c9e6d81f75d14d67064b78e@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 6 Aug 2007 20:25:13 +0200
Segher Boessenkool <segher@kernel.crashing.org> wrote:

> >>>>> +				max-speed-hz = <bebc20>; /* 12500000 Hz */
> >>
> >> Just max-speed.
> >
> > Segher, how is this different from:
> >
> > http://ozlabs.org/pipermail/linuxppc-dev/2007-April/034557.html
> 
> Not sure what you mean.  I'm just saying that "speed-hz" is a
> terrible name, I'm not saying that "max-speed" is perfect at all.

yet you suggest a /more/ generic name, contrary to your prior comments.

My interpretation of your recent comments is that 'max-speed' is now a
valid property name for devices such as ucc_geth.  Do I have that right?

Kim
