Message-Id: <200011192002.eAJK28Y23640@shell.faradic.net>
Date: Sun, 19 Nov 2000 15:02:08 -0500
From: jingai <jingai@floatingpenguins.com>
To: "linuxppc-dev" <linuxppc-dev@lists.linuxppc.org>
Subject: No Subject
Reply-To: jingai@floatingpenguins.com
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This may not be the appropriate list to post this on, but since it
does work on my x86 box at work, here goes...

I'm having trouble burning multisession discs with cdrdao.  My
TOC file is as follows:

CD_ROM_XA
TRACK AUDIO
FILE "audio.raw" 0

TRACK MODE2_FORM1
DATAFILE "data.raw"

And the command line:

cdrdao write --multi --device 1,4,0 my.toc

Here is the output from cdrdao:

Cdrdao version 1.1.3 - (C) Andreas Mueller <mueller@daneb.ping.de>
  SCSI interface library - (C) Joerg Schilling
  L-EC encoding library - (C) Heiko Eissfeldt
  Paranoia DAE library - (C) Monty

1,4,0: YAMAHA CRW6416S  Rev: 1.0c
Using driver: Generic SCSI-3/MMC - Version 1.0 (data) (options 0x0000)

Starting write simulation at speed 6...
Pausing 10 seconds - hit CTRL-C to abort.
Process can be aborted with QUIT signal (usually CTRL-\).
Using POSIX real time scheduling.
Executing power calibration...
cdrdao: No such device or address. Cannot set SG_SET_TIMEOUT.

It is apparently failing on the power calibration, but with the same
CD writer at work, it does not fail here.

My second problem happens both on x86 and PowerPC.  If I
specify the --multi option to cdrdao, it fails shortly after the
burn begins (it does write some data to the disc though) with
a buffer underrun.  If I omit the --multi option, it burns fine
on x86.  Seeing as I am trying to burn a multisession disc,
it's kind of necessary (I think?) to specify the --multi
option.

Both boxes are running Debian woody and kernel 2.2.18pre21.

Any help would be greatly appreciated.

Regards,
Jonathan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
