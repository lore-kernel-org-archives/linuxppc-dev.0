Date: Mon, 29 Apr 2002 08:57:37 +0200 (CEST)
From: Marius Groeger <mag@sysgo.de>
To: andrew may <acmay@acmay.homeip.net>
Cc: Nye Liu <nyet@zumanetworks.com>, John Tyner <jtyner@cs.ucr.edu>,
	<linuxppc-embedded@lists.linuxppc.org>,
	<ppcboot-users@lists.sourceforge.net>
Subject: MTD Partitioning (Was: [PATCH][RFC] PPCBoot Environment Kernel
 Module)
In-Reply-To: <20020425144813.E22212@ecam.san.rr.com>
Message-ID: <Pine.LNX.4.40.0204290852220.689-100000@mag.devdep.sysgo.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 25 Apr 2002, andrew may wrote:

> > > Well one thing that we plan (John and I work together) ontop of
> > > this is to use some env vars for the partition table for flash.
> >
> > Ummm... "use some env vars for the partition table for flash".
>
> see linux/drivers/mtd/redboot.c and any of the mtd/maps/*.c that
> call add_mtd_partitions() as for the partitions I am talking about.

Good news for you guys here: we just checked in a new module on
infradead.org implementing just that. It's drivers/mtd/cmdline.c and
allows you to specify the entire partition table via a kernel command
line option. Thus, on ppcboot/armboot, you just set the bootargs
variable and be done with it.

I'd be interested in any feedback on this.

Regards
Marius

-----------------------------------------------------------------------------
Marius Groeger           SYSGO Real-Time Solutions GmbH     mgroeger@sysgo.de
Software Engineering     Embedded and Real-Time Software    www.sysgo.de
Voice: +49-6136-9948-0   Am Pfaffenstein 14                 www.osek.de
FAX:   +49-6136-9948-10  55270 Klein-Winternheim, Germany   www.elinos.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
