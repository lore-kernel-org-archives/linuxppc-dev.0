From: okorpil@fh-landshut.de
Date: Thu, 1 Apr 2004 12:55:47 +0200 (CEST)
Reply-To: okorpil@fh-landshut.de
To: linuxppc-embedded@lists.linuxppc.org
Subject: Serial Console / Booting Linux with the PPCbug on MVME2100?
Message-ID: <Pine.LNX.4.58.0404011242110.11973@ppcproject1>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


To complete the information about what I tried to make it work:

Network PReP-Boot Mode Enable [Y/N] = Y

is in NVRAM.

The board is a MVME2100 with a MPC8240 microcontroller (both from
Motorola). I want to use a serial console only (no PMC VGA card). I may
use either netboot or from RAM/Flash (with NFS after) for booting, but I
have no harddisk.

I've built kernels for CHRP/PREP and for Sandpoint.

I've built kernels for PPLUS, LOPEC and PRMPC750, and tried their bugboot
images.

I've tried a mkbugboot modified zImage.prep and vmlinux.gz (for PREP).

I do not get beyond the "Residual Data Located at xxx" step, then it seems
to hang (with the PREP image). All others images produce Alignment or
other errors. Several others seem to have gone beyond the step with a
similar config, so I wonder.

I attached my .config to another post to the same Subject.

Some people seem to have built for a similar configuration with
CONFIG_PREP, but this seems to have already vanished from the list of
configuration macros (and from grepping the kernel source).

I seem to have problems building a kernel for a 8260 config - is this
broken?

I've nearly completely run out of ideas and hope someone of you people
knows something about this.

Thanks in advance,
Oliver Korpilla

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
