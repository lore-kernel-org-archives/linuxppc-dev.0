Date: Sat, 5 Aug 2000 22:18:29 -0700
From: Matt Porter <mporter@mvista.com>
To: "Todd C. Larsen" <tlarsen@openbits.net>
Cc: LinuxPPC Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: LinuxPPC running on an EST SBC740 board?
Message-ID: <20000805221829.A20430@beef.az.mvista.com>
References: <00b201bffe42$7dd12b60$1a0210ac@r2d2> <20000805075902.A1324@cx258813-a.chnd1.az.home.com> <009301bfff55$c9c09dd0$2424010a@r2d2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <009301bfff55$c9c09dd0$2424010a@r2d2>; from tlarsen@openbits.net on Sat, Aug 05, 2000 at 08:24:09PM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sat, Aug 05, 2000 at 08:24:09PM -0700, Todd C. Larsen wrote:
> Matt,
>
> Thanks for the suggestion, but I've got some custom hardware that
> I'm trying to find a close match for, and it has an MPC106 PCI
> bridge/memory controller.  The EST SBC740 board has an MPC106 as
> well.  Also, many PReP reference boards and PowerPC VME boards
> (except for those from MCG, which use the Raven, etc.) use the
> MPC106, so I'm hoping LinuxPPC running on one of these will be
> similar.

EST is probably the way to go in your case then.  A shame
considering theu are WindRiver. :-/

Oh, FYI, a non-reference platform that matches your custom hardware
is the SBS Denali board (http://www.sbs.com).  It has a 740 and 106
bridge  with a DEC21x4x and DEC21554 in a cPCI form factor.

> The IBM boards use PCI bridge chips specific to IBM, as far as I
> can tell.  Someone please correct me if I'm wrong...

The CPC700 is no more specific to IBM than the MPC105/6/7 are specific
to Motorola.  I've worked on on boards with Raven/Hawk's, MPC105/6/7,
Galileo, CPC710, and CPC700.  The IBM bridges are by far the most
versatile bridges on the open market (Raven/Hawk aren't available
except on an MCG board).

I'm seeing a lot of boards now becoming available with the CPC700.
About the only thing missing is a DMA engine which its cousin, the
CPC710, does have.

Good luck,
--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
