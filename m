Return-Path: <rmachet@slac.stanford.edu>
Received: from nospam3.slac.stanford.edu (nospam3.slac.stanford.edu
	[134.79.18.120])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5ED6ADDFA9
	for <linuxppc-dev@ozlabs.org>; Sat, 17 May 2008 01:46:36 +1000 (EST)
Subject: Re: [PATCH 2/5] powerpc: boot code for the C2K
From: Remi Machet <rmachet@slac.stanford.edu>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20080516015647.GB27188@yookeroo.seuss>
References: <1210897421.13992.14.camel@pcds-ts102.slac.stanford.edu>
	<20080516015647.GB27188@yookeroo.seuss>
Content-Type: text/plain
Date: Fri, 16 May 2008 08:46:59 -0700
Message-Id: <1210952820.13992.25.camel@pcds-ts102.slac.stanford.edu>
Mime-Version: 1.0
Cc: Linux PPC <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-05-16 at 11:56 +1000, David Gibson wrote:
> On Thu, May 15, 2008 at 05:23:40PM -0700, Remi Machet wrote:
> > Support for the C2K cPCI Single Board Computer from GEFanuc
> > (PowerPC MPC7448 with a Marvell MV64460 chipset)
> > All features of the board are not supported yet, but the board
> > boots, flash works, all Ethernet ports are working and PCI 
> > devices are all found (USB and SATA on PCI1 do not work yet).
> > 
> > Part 2 of 5: support for the board in arch/powerpc/boot.
> > 
> > Signed-off-by: Remi Machet <rmachet@slac.stanford.edu>
> 
> [snip]
> > +BSS_STACK(16*KB);
> 
> 16kB is a really big stack for a bootwrapper.  Do you really need this
> much?
> 
No, it was in the PRPMC2800 board file that I took as an example. I will
tune that a little bit better and resubmit the patch.

Thanks !

Remi
