Date: Tue, 24 Aug 1999 22:16:32 -0400 (EDT)
From: Hollis R Blanchard <hollis+@andrew.cmu.edu>
Reply-To: Hollis R Blanchard <hollis+@andrew.cmu.edu>
To: Michael_Joy@diitech.com, gthomas@cygnus.co.uk, jahluwal@cs.ucr.edu
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: IBM 850 LinuxPPC installation?
In-Reply-To: <862567D7.00824CC0.00@eagles.designsol.com>
Message-ID: <Pine.LNX.3.96L.990824214016.3087N-100000@unix47.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


More on Linux on the IBM Power Series 850:

I've gotten a kernel compiled (and it boots!) with ethernet ("Lance") support.
It also has IDE disk and cdrom support (which makes installing to a hard disk
much easier). Unfortunately, I've run into a problem - the kernel hangs on
Partition check:
  hda:

If I specify "hda=none" on the kernel cmdline, it hangs on hdb. If I specify
"hda=none hdb=none" it goes all the way to "Insert ram disk floppy #1" before
the screen flashes black and it's hung again.

Does anyone know what the IDE controller is on these machines? There are a few
nonstandard controllers that need to be explicitly specified on the command
line.

Here's the IDE info I get before it hangs:
hda: DPEA-31080, ATA DISK drive
hda: IRQ probe failed (0)
hdb: DSAA-3720, ATA DISK drive
hdb: IRQ probe failed (0)
hdc: IRQ probe failed (0)
hdc: IRQ probe failed (0)
hdc: no response (status = 0xd1), resetting drive
hdc: no response (status =0x80)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 13
hda: DPEA-31080, 1033MB w/448kb Cache, CHS=2100/16/63
hdb: DSAA-3720, 696MB w/96kb Cache, CHS=1416/16/63

This machine has two hard drives (1GB and 700MB) on bus 0 and a CD-ROM drive
as a master on bus 1.

-Hollis


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
