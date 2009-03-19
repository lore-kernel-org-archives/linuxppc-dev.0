Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6843CDDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Mar 2009 03:11:05 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n2JGB3Wn006341
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 09:11:03 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n2JGB2N3008083
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 11:11:02 -0500 (CDT)
Date: Thu, 19 Mar 2009 11:11:02 -0500
From: Scott Wood <scottwood@freescale.com>
To: Li Yang-R58472 <LeoLi@freescale.com>
Subject: Re: suspend-to-mem on the mpc8349e-mitx-gp?
Message-ID: <20090319161101.GA2304@ld0162-tx32.am.freescale.net>
References: <ffa0ad880903182246y4323e31bv6109fbf748858af0@mail.gmail.com>
	<3A45394FD742FA419B760BB8D398F9ED29EAC6@zch01exm26.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3A45394FD742FA419B760BB8D398F9ED29EAC6@zch01exm26.fsl.freescale.net>
Cc: linuxppc-dev@ozlabs.org, Soohyung Cho <celius202@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 19, 2009 at 12:24:26AM -0700, Li Yang-R58472 wrote:
> > -----Original Message-----
> > From: linuxppc-dev-bounces+leoli=freescale.com@ozlabs.org 
> > [mailto:linuxppc-dev-bounces+leoli=freescale.com@ozlabs.org] 
> > On Behalf Of Soohyung Cho
> > Sent: Thursday, March 19, 2009 1:47 PM
> > To: linuxppc-dev@ozlabs.org; Wood Scott-B07421
> > Subject: suspend-to-mem on the mpc8349e-mitx-gp?
> > 
> > Hello.
> > 
> > I need to enable suspend-to-mem(deep sleep) on my 
> > mpc8349e-mitx-gp box.
> > When I send "mem" message to /sys/power/state, the box seems 
> > to get stop.
> > I think the box get stop when it executes suspend-asm.S codes.
> > 
> > I know that the latest linux supports suspend-to-mem on the 
> > mpc8313erdb box well.
> > Is it impossible to enable suspend-to-mem on the mpc8349e-mitx-gp?
> 
> I don't think the MPC8349 hardware has the deep sleep functionality.

However, the code should treat "mem" as "standby" on chips that don't
support deep sleep.  What does the device tree look like (the upstream
device tree for that board does not have any reference to the PMC)?  What
kernel are you using?

-Scott
