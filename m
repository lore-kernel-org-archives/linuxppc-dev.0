Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2C33FDDE27
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Nov 2007 11:00:12 +1100 (EST)
Subject: Re: [PATCH 12/14] powerpc: Add early udbg support for 40x processors
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40711211547nf9d58c4t1bc7a512c699cb02@mail.gmail.com>
References: <20071121061555.55B06DDFA8@ozlabs.org>
	<fa686aa40711211547nf9d58c4t1bc7a512c699cb02@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 22 Nov 2007 11:00:01 +1100
Message-Id: <1195689601.6970.115.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2007-11-21 at 16:47 -0700, Grant Likely wrote:
> On 11/20/07, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > This adds some basic real mode based early udbg support for 40x
> > in order to debug things more easily
> >
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > ---
> > --- linux-work.orig/arch/powerpc/platforms/Kconfig.cputype      2007-11-21 12:50:16.000000000 +1100
> > +++ linux-work/arch/powerpc/platforms/Kconfig.cputype   2007-11-21 12:50:18.000000000 +1100
> > @@ -43,6 +43,7 @@ config 40x
> >         bool "AMCC 40x"
> >         select PPC_DCR_NATIVE
> >         select WANT_DEVICE_TREE
> > +       select PPC_UDBG_16550
> 
> Unfortunately, this isn't always true.  The Xilinx Virtex parts us
> config 40x, but not all FPGA bitstreams have a 16550 serial port.
> Sometimes it's a uartlite instead.

What does uartlite looks like ?

Ben.
