Return-Path: <schivers@csc.com.au>
Received: from mail1.bemta7.messagelabs.com (mail1.bemta7.messagelabs.com
 [216.82.254.107])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C510D2C00BC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jan 2014 06:27:43 +1100 (EST)
In-Reply-To: <1389138670.11795.208.camel@snotra.buserror.net>
References: <20140106012306.A6AB5E06BF@canberra.localdomain>
 <1389138670.11795.208.camel@snotra.buserror.net>
To: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
Subject: Re: [PATCH v5 1/1] powerpc/embedded6xx: Add support for
 Motorola/Emerson MVME5100
From: Stephen N Chivers <schivers@csc.com.au>
Message-ID: <OF3DECBCBD.620CC800-ONCA257C5A.006A2BFE-CA257C5A.006A44BC@csc.com>
Date: Thu, 9 Jan 2014 05:20:42 +1000
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org, Stephen N Chivers <schivers@csc.com.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood <scottwood@freescale.com> wrote on 01/08/2014 10:51:10 AM:

> From: Scott Wood <scottwood@freescale.com>
> To: Stephen N Chivers/AUS/CSC@CSC
> Cc: <benh@kernel.crashing.org>, <linuxppc-dev@lists.ozlabs.org>
> Date: 01/08/2014 10:51 AM
> Subject: Re: [PATCH v5 1/1] powerpc/embedded6xx: Add support for 
> Motorola/Emerson MVME5100
> 
> On Mon, 2014-01-06 at 12:23 +1100, Stephen Chivers wrote:
> > Add support for the Motorola/Emerson MVME5100 Single Board Computer.
> > 
> > The MVME5100 is a 6U form factor VME64 computer with:
> > 
> >    - A single MPC7410 or MPC750 CPU
> >    - A HAWK Processor Host Bridge (CPU to PCI) and
> >      MultiProcessor Interrupt Controller (MPIC)
> >    - Up to 500Mb of onboard memory
> >    - A M48T37 Real Time Clock (RTC) and Non-Volatile Memory chip
> >    - Two 16550 compatible UARTS
> >    - Two Intel E100 Fast Ethernets
> >    - Two PCI Mezzanine Card (PMC) Slots
> >    - PPCBug Firmware
> > 
> > The HAWK PHB/MPIC is compatible with the MPC10x devices.
> > 
> > There is no onboard disk support. This is usually provided by 
> installing a PMC
> > in first PMC slot.
> > 
> > This patch revives the board support, it was present in early 2.6
> > series kernels. The board support in those days was by Matt Porter of
> > MontaVista Software.
> > 
> > CSC Australia has around 31 of these boards in service. The kernel in 
use
> > for the boards is based on 2.6.31. The boards are operated without 
disks
> > from a file server. 
> > 
> > This patch is based on linux-3.13-rc2 and has been boot tested.
> > 
> > Only boards with 512 Mb of memory are known to work.
> > 
> > V1->V2:
> >    Address comments by Kumar Gala and Scott Wood.
> >    Minor adjustment to platforms/embedded6xx/Kconfig to ensure
> >       correct indentation where possible.
> > 
> > V2->V3:
> >    Address comments by Scott Wood and Ben Herrenschmidt.
> >    Address errors reported by checkpatch.
> > 
> > V3->V4:
> >    Address comment by Geert Uytterhoeven
> >    Add tested by Alessio Bogani.
> > 
> > V4->V5:
> >    Correct horrible typo in patch history.
> >    Kular Gama is Kumar Gala.
> 
> The patch history should go below the --- line, as it's for reviewers
> who have seen previous versions rather than for the git history.
Ok.
> 
> -Scott
> 
> 
