Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 85F53DE39A
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Apr 2008 04:52:55 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m3MIqihL015258
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 11:52:45 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m3MIqi40028772
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 13:52:44 -0500 (CDT)
Date: Tue, 22 Apr 2008 13:52:44 -0500
From: Scott Wood <scottwood@freescale.com>
To: Andre Schwarz <andre.schwarz@matrix-vision.de>
Subject: Re: Question on MPC83xx interrupts
Message-ID: <20080422185244.GA20229@ld0162-tx32.am.freescale.net>
References: <480E1939.6000701@matrix-vision.de>
	<20080422172306.GA17992@ld0162-tx32.am.freescale.net>
	<480E2230.2030601@matrix-vision.de>
	<20080422174208.GB18076@ld0162-tx32.am.freescale.net>
	<480E33AB.5050904@matrix-vision.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <480E33AB.5050904@matrix-vision.de>
Cc: linux-ppc list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 22, 2008 at 08:51:23PM +0200, Andre Schwarz wrote:
> Scott Wood schrieb:
> >On Tue, Apr 22, 2008 at 07:36:48PM +0200, Andre Schwarz wrote:
> >  
> >>thanks - any Idea how to figure out where the BAD comes from ?
> >>Is it simply an unhandled/unacked one ?
> >>    
> >
> >It generally happens when an interrupt is requested, and the core 
> >takes
> >the exception, but then the interrupt source deasserts itself.
> >
> >-Scott
> So this is not bad at all if you have a device with self-clearing 
> interrupts ...

Right, as long as you don't get too many of them I wouldn't worry.

-Scott
