Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp05.au.ibm.com (ausmtp05.au.ibm.com [202.81.18.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 032F7DDEF6
	for <linuxppc-dev@ozlabs.org>; Fri, 11 May 2007 11:46:35 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by ausmtp05.au.ibm.com (8.13.8/8.13.8) with ESMTP id l4B1mHdH5922854
	for <linuxppc-dev@ozlabs.org>; Fri, 11 May 2007 11:48:17 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.250.243])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4B1o2Fv123688
	for <linuxppc-dev@ozlabs.org>; Fri, 11 May 2007 11:50:03 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4B1kUE3014665
	for <linuxppc-dev@ozlabs.org>; Fri, 11 May 2007 11:46:31 +1000
Date: Fri, 11 May 2007 11:46:29 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: Building ppc/powerpc kernel to run under QEMU.
Message-ID: <20070511014629.GA31705@localhost.localdomain>
References: <200705092203.26042.rob@landley.net>
	<20070510172806.GE4452@austin.ibm.com>
	<464397B8.408@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <464397B8.408@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org, Rob Landley <rob@landley.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 10, 2007 at 11:07:52PM +0100, Matt Sealey wrote:
> QEMU really really wants a PREP kernel, and that stuff's just not in the new
> arch/powerpc tree anymore is it?

qemu is PReP, eh?  Well that would explain the not working: PReP
hasn't been ported to arch/powerpc yet.  The fact that qemu acts like
a PReP might make doing so rather easier.

> I'd love to see the device tree once QEMU's kernel has booted :D
> 
> I wonder.. would it be useful to have a qemu platform in arch/powerpc and
> for someone to start hacking in devices from a non-emulated point of view?
> It seems a bit of a waste in my mind to emulate a network card, serial port
> IDE interface, ADB (yick!) and a VESA graphics adapter in such 'detail' when
> it can be passed back to the emulation somehow through some kind of clever
> call interface (maybe just have the zero page of the emulation contain a
> bunch of 'ports' which are really function calls pointers..?)

Possibly in the long term.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
