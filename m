Return-Path: <schivers@csc.com.au>
Received: from mail1.bemta7.messagelabs.com (mail1.bemta7.messagelabs.com
 [216.82.254.100])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.bemta7.messagelabs.com",
 Issuer "VeriSign Class 3 International Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 124832C0108
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Aug 2013 07:13:11 +1000 (EST)
In-Reply-To: <B7B7FD2F-8272-487C-B946-154107EF7C09@kernel.crashing.org>
References: <OFBCFBBD51.E4ECB0DF-ONCA257BC0.0083C866-CA257BC1.0000531E@csc.com>
 <B7B7FD2F-8272-487C-B946-154107EF7C09@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH 1/1] powerpc/embedded6xx: Add support for
 Motorola/Emerson MVME5100.
From: Stephen N Chivers <schivers@csc.com.au>
Message-ID: <OFB9168ADE.6CCD0AEA-ONCA257BC5.0073A187-CA257BC5.0073F0D1@csc.com>
Date: Tue, 13 Aug 2013 08:06:14 +1100
Content-Type: text/plain; charset="US-ASCII"
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 Chris Proctor <cproctor@csc.com.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kumar Gala <galak@kernel.crashing.org> wrote on 08/09/2013 01:30:53 AM:

> From: Kumar Gala <galak@kernel.crashing.org>
> To: Stephen N Chivers <schivers@csc.com.au>
> Cc: benh@kernel.crashing.org, paulus@samba.org, Chris Proctor 
> <cproctor@csc.com.au>, linuxppc-dev@lists.ozlabs.org
> Date: 08/09/2013 01:31 AM
> Subject: Re: [RFC PATCH 1/1] powerpc/embedded6xx: Add support for 
> Motorola/Emerson MVME5100.
> 
> 
> On Aug 7, 2013, at 7:03 PM, Stephen N Chivers wrote:
> 
> > Add support for the Motorola/Emerson MVME5100 Single Board Computer.
> > 
> > The MVME5100 is a 6U form factor VME64 computer with:
> > 
> >        - A single MPC7410 or MPC750 CPU
> >        - A HAWK Processor Host Bridge (CPU to PCI) and
> >          MultiProcessor Interrupt Controller (MPIC)
> >        - Up to 500Mb of onboard memory
> >        - A M48T37 Real Time Clock (RTC) and Non-Volatile Memory chip
> >        - Two 16550 compatible UARTS
> >        - Two Intel E100 Fast Ethernets
> >        - Two PCI Mezzanine Card (PMC) Slots
> >        - PPCBug Firmware
> > 
> > The HAWK PHB/MPIC is compatible with the MPC10x devices.
> > 
> > There is no onboard disk support. This is usually provided by 
installing a 
> > PMC
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
> > This patch is based on linux-3.11-rc4 and has been boot tested.
> > 
> > Signed-off-by: Stephen Chivers <schivers@csc.com>
> > ---
> > arch/powerpc/boot/dts/mvme5100.dts            |  195 ++
> > arch/powerpc/boot/mvme5100.c                  |   28 +
> > arch/powerpc/configs/mvme5100_defconfig       | 2597 
> > +++++++++++++++++++++++++
> > arch/powerpc/platforms/embedded6xx/mvme5100.c |  288 +++
> > 4 files changed, 3108 insertions(+), 0 deletions(-)
> 
> Please look at fixing the white space issues you seem to have 
> throughout this patch.
The mailing agent is Lotus Notes. It is pathologically against tabs. I did
make best effort to ensure that tabs would not get crunched but sadly this
has failed.
> 
> Also, we don't take full defconfigs in the tree, look at 'make 
savedefconfig'
Ok.
> 
> - k
> 
