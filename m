Message-ID: <38C3A7DE.E6E4FB40@ocegr.fr>
Date: Mon, 06 Mar 2000 13:43:10 +0100
From: Zirong WANG <zirong.wang@ocegr.fr>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: IDE disk problem with MTX 603
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi everybody,

I am trying hardly to make work my ide disk on my MTX 603 machine,
---> without success.

I have installed 2.2.10 on my MTX 603 on a SCSI disk. I compiled
the kernel with ide support enabled and reboot with PPCBug

What I get during the boot time is something like:

  IDE timing: 00000909, resetting to PIO0 timing
  IDE control/status register: 00ff0091
  hda: Conner Peripherals 1275MB - CFS1276A, ATA DISK drive
  ide0: Disabled unable to get IRQ 16.
  hda: ERROR, PORTS ALREADY IN USE


By the way, when using kernel 2.2.14, the IDE disk detection seems to
go further, but the scsi disk detection enters a infinite
timeout/reset loop.

So I am stuck,

any suggestion?

Thanks
---------------------------------------------------------------------
Zirong WANG  Oce Industries  1, rue Jean Lemoine 94015 Creteil France

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
