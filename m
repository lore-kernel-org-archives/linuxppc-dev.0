Message-ID: <009301bfff55$c9c09dd0$2424010a@r2d2>
From: "Todd C. Larsen" <tlarsen@openbits.net>
To: "Matt Porter" <mporter@mvista.com>
Cc: "LinuxPPC Embedded" <linuxppc-embedded@lists.linuxppc.org>
References: <00b201bffe42$7dd12b60$1a0210ac@r2d2> <20000805075902.A1324@cx258813-a.chnd1.az.home.com>
Subject: Re: LinuxPPC running on an EST SBC740 board?
Date: Sat, 5 Aug 2000 20:24:09 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Matt,

Thanks for the suggestion, but I've got some custom hardware that
I'm trying to find a close match for, and it has an MPC106 PCI
bridge/memory controller.  The EST SBC740 board has an MPC106 as
well.  Also, many PReP reference boards and PowerPC VME boards
(except for those from MCG, which use the Raven, etc.) use the
MPC106, so I'm hoping LinuxPPC running on one of these will be
similar.

The IBM boards use PCI bridge chips specific to IBM, as far as I
can tell.  Someone please correct me if I'm wrong...

-Todd


> On Fri, Aug 04, 2000 at 11:33:31AM -0700, Todd C. Larsen wrote:
> >
> > Has anyone attempted to boot Linux on an SBC740 (or SBC603, SBC750)
> > development board from EST?  So far, it looks like one of the best
> > candidates for an evaluation board for the MPC740, since Motorola
> > no longer sells the Yellowknife X4.  I was just wondering if anyone
> > else on the list had experiences with this board.
>
> How about an alternative?  What about the IBM CPC700 reference
> platform with a 740?
>
> http://www.chips.ibm.com/products/powerpc/tools/600_ekit.html
>
> There is already somebody booting a limping partial port to this
> board using a 750.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
