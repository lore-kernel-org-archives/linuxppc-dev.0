Date: Mon, 27 Aug 2001 03:45:07 -0700
From: Matt Porter <mporter@mvista.com>
To: Brian Waite <bwaite@cspi.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: SCSI PMC card
Message-ID: <20010827034507.B23912@cx258813-a.chnd1.az.home.com>
References: <85256AB1.005815DF.00@pine.cspi.com> <200108241930.PAA15782@orchid.cspi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200108241930.PAA15782@orchid.cspi.com>; from bwaite@cspi.com on Fri, Aug 24, 2001 at 03:23:10PM -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Aug 24, 2001 at 03:23:10PM -0400, Brian Waite wrote:
>
> Ok now I moved up to a 2.4.9 kernel from the linuxppc_2_4_stable tree and I
> see the same problem. Here is the output of debug being defined in both
> drivers/pci.c and arch/ppc/kernel/pci.c. Below are the dumps of 2 boots, one
> without the SCSI card attached and one with the SCSI card attached to the
> baseboard. Does anything looks suspicious? This card did work on the base
> under 2.2.18 when I initiaslly tested it.

Everything looks good...excepting the unassigned resource (which isn't
used by the tulip driver anyway).  I've never seen a hard hang except
on a new bridge design bringup so you're going to have to trace the
flow through all the resource assignment process.

> PS I can't seem to get my 2.4 devel tree to boot on the 2400, the
> decompress_kernel fails with fffffffd.

I think Gabriel Paubert is the only other person I've seen using  Linux
on a 2400 lately...maybe he'll chime in.  It could be a temporary effect
of the bootloader reorg right now...prep is being touched.

Regards,
--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
