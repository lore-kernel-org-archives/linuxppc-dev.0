Date: Fri, 4 Aug 2000 07:19:54 -0700
From: Matt Porter <mporter@mvista.com>
To: Ronald Wahl <rwa@peppercon.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: iounmap
Message-ID: <20000804071954.C892@beef.az.mvista.com>
References: <20000803155911.A6226@cx258813-a.chnd1.az.home.com> <Pine.LNX.4.21.0008041003040.653-100000@goliath.issistance.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.21.0008041003040.653-100000@goliath.issistance.de>; from rwa@peppercon.de on Fri, Aug 04, 2000 at 10:06:26AM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Aug 04, 2000 at 10:06:26AM +0200, Ronald Wahl wrote:
> On Thu, 3 Aug 2000, Matt Porter wrote:
>
> > On Thu, Aug 03, 2000 at 02:44:12PM +0200, Geert Uytterhoeven wrote:
> > >
> > > On Thu, 3 Aug 2000, Ronald Wahl wrote:
> > > > I'm currently writing a device driver for an pci controller and have to
> > > > map very large amounts of pci memory and i/o ranges via ioremap. The
> > > > problem is that there is no iounmap and ioremap returns NULL after some
> > > > insmod/rmmod cycles. When gets this implemented?
> > >
> > > When someone steals some spare time and writes the code.
> >
> > Done.  The hot swap PCI kernel patches from MCG have iounmap implemented.
> > Very useful when ripping a PCI peripheral out of its slot. :)
> >
> > See them at http://www.mcg.mot.com/linux under HA Linux/Downloads.
>
> Call me blind, but I havn't seen an implementation of iounmap in these
> patches.

Whoops, sorry.  When I was at MCG I know another engineer did an iounmap
implementation for HA support.  I thought it was in those patches... :-/

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
