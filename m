Subject: new code for an mpc8xx board (dbox2)
From: Andreas Oberritter <obi@saftware.de>
To: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain
Message-Id: <1059878529.665.50.camel@localhost>
Mime-Version: 1.0
Date: 03 Aug 2003 04:42:09 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I'd like to get support for the dbox2, which is a DVB receiver with an
mpc823 cpu, into the linux kernel, to make it bootable without
further patching. Since I am new to submitting kernel patches, I don't
know who to ask best for inclusion. Benjamin Herrenschmidt pointed me to
this mailing list.

On which kernel tree shall patches be based to get into vanilla 2.4?

The current patchset against linux-2.4.22-pre6 can be viewed via webcvs
at http://cvs.tuxbox.org/cgi-bin/viewcvs.cgi/tuxbox/cdk/Patches/

I will create a new set as soon as I know which tree to use best.

I'd also like to know if there is a better way to handle edge triggered
interrupts on 8xx than it is done in
linux-2.4.22-pre6-dbox2-irq.diff. Should CONFIG_DBOX2 be removed in this
patch or maybe replaced by CONFIG_8xx?

I think linux-2.4.22-pre6-dbox2-board.diff is a trivial patch and will
not offend any other boards.

linux-2.4.22-pre6-dbox2-watchdog.diff is needed because the
bootloader of this board enables the watchdog. Since it is a generic
implementation for handling an 8xx watchdog, I'd add CONFIG_8xx_WATCHDOG
for it instead of CONFIG_DBOX2, if no one complains.

Regards,
Andreas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
