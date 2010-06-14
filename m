Return-Path: <nico@fluxnic.net>
Received: from relais.videotron.ca (relais.videotron.ca [24.201.245.36])
	by ozlabs.org (Postfix) with ESMTP id B7334B7D1C
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jun 2010 03:26:15 +1000 (EST)
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
	(Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007;
	32bit))
	with ESMTP id <0L40000K2LRPVXK0@VL-MO-MR005.ip.videotron.ca> for
	linuxppc-dev@ozlabs.org; Mon, 14 Jun 2010 13:26:13 -0400 (EDT)
Date: Mon, 14 Jun 2010 13:26:13 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Mitch Bradley <wmb@firmworks.com>
Subject: Re: Request review of device tree documentation
In-reply-to: <4C165FD1.6080505@firmworks.com>
Message-id: <alpine.LFD.2.00.1006141311580.13427@xanadu.home>
References: <4C13430B.5000907@firmworks.com>
	<1276339529.1962.184.camel@pasglop> <1276339684.1962.186.camel@pasglop>
	<4C13B618.1030006@firmworks.com> <1276383132.1962.195.camel@pasglop>
	<AANLkTimRV8u3gDNCAIlROJoPcKs7jFwj2na3ZDFOg3O0@mail.gmail.com>
	<4C146F18.9030008@firmworks.com>
	<AANLkTikls3hjXOmKFqG2D_9GaJSjOXNuuRXPlanAjo5E@mail.gmail.com>
	<20100614124438.GF9323@yookeroo>
	<alpine.LFD.2.00.1006141044510.13427@xanadu.home>
	<20100614160201.GD9550@shareable.org> <4C165FD1.6080505@firmworks.com>
Cc: microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
	Jamie Lokier <jamie@shareable.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Dan Malek <ppc6dev@digitaldans.com>,
	Jeremy Kerr <jeremy.kerr@canonical.com>,
	linux-arm-kernel@lists.infradead.org,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 14 Jun 2010, Mitch Bradley wrote:

> First, the primary use case for "keeping OFW alive" is for debugging purposes.
> OFW remains resident in memory so that, if the OS is set to allow it (not the
> default), a hot-key freezes the OS and enters OFW, where a human can inspect
> the state of devices and OS data structures. A high skill level is required,
> so it's okay if some fiddling is necessary to find or establish virtual
> addresses or do similar magic .  

Why would you impose such pain on yourself in order to try to make OFW a 
viable debugging tool on ARM for live kernels, while you can achieve the 
same and more much less intrusively and so much more safely with a JTAG 
based debugger?

If the cost of a JTAG solution is a concern, you can order USB based 
JTAG dongles on the net for less than $30 and use them with OpenOCD[1].

Otherwise, what's wrong with already supported kgdb, or even kdb?

[1] http://openocd.berlios.de/web/


Nicolas
