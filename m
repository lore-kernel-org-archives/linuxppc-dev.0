Message-ID: <39F9D22B.23BDE8E9@mvista.com>
Date: Fri, 27 Oct 2000 12:06:19 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
Reply-To: mgreer@mvista.com
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Early PCI auto-configuration
References: <Pine.LNX.4.10.10010271921050.390-100000@cassiopeia.home>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven wrote:

> <cut>
>
> > cards, the pcibios_assign_resources() function will assign bases
> > addresses to unassigned devices. This is done by the call to
> > pcibios_assign_resources(), and works if your bus resources & ranges have
> > been setup properly.
>
> Yep. If you set up the bus resources correctly, that code will assign all
> unassigned resources automatically (and reassign conflicting resources) from
> the ranges specified by the bus resources.
>
> BTW, before I did this on PPC, I played with PCI resource assignment on a MIPS
> board, where the firmware didn't do any PCI assignments (except for Ethernet,
> to boot images using TFTP), which is exactly what you want. For reference, that
> code is in arch/mips/ddb5074/pci.c.

Geert, Ben, Matt,

Thanks for the feedback.  I've looked through much of the code you guys pointed
out and it does look like it will do what I want.  I'll hook it up and see how it
goes.

Mark


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
