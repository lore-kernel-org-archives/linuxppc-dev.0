Date: Thu, 3 Aug 2000 15:59:11 -0700
From: Matt Porter <mporter@mvista.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ronald Wahl <rwa@peppercon.de>, linuxppc-dev@lists.linuxppc.org
Subject: Re: iounmap
Message-ID: <20000803155911.A6226@cx258813-a.chnd1.az.home.com>
References: <Pine.LNX.4.21.0008030950020.1647-100000@goliath.issistance.de> <Pine.LNX.4.10.10008031443520.425-100000@cassiopeia.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.10.10008031443520.425-100000@cassiopeia.home>; from geert@linux-m68k.org on Thu, Aug 03, 2000 at 02:44:12PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Aug 03, 2000 at 02:44:12PM +0200, Geert Uytterhoeven wrote:
>
> On Thu, 3 Aug 2000, Ronald Wahl wrote:
> > I'm currently writing a device driver for an pci controller and have to
> > map very large amounts of pci memory and i/o ranges via ioremap. The
> > problem is that there is no iounmap and ioremap returns NULL after some
> > insmod/rmmod cycles. When gets this implemented?
>
> When someone steals some spare time and writes the code.

Done.  The hot swap PCI kernel patches from MCG have iounmap implemented.
Very useful when ripping a PCI peripheral out of its slot. :)

See them at http://www.mcg.mot.com/linux under HA Linux/Downloads.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
