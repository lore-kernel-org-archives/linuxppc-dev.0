Date: Sat, 11 Nov 2000 19:08:41 +1100
From: Steven Hanley <sjh@svana.org>
To: Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: success sort of with 2.2.10
Message-ID: <20001111190841.A8799@wibble.net>
Reply-To: Steven Hanley <sjh@wibble.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


All

well 2.2.10 will get past the blank screen on my 7220, 2.2.18pre18 and
2.2.17 (came with debian) both dont.

Now it has frozen booting the kernel at the line after detecting hdc
the output looks like
hda: QUANTUM FIREBALL ST2100A, ATA DISK drive
hdc: MATSHITA CR-585, ATAP CDROM drive
ide0 at 0x01020000-0x1020007,0x1020160 on irq 13

is that the right output? on my x86 it says ide0 0x1f0-0x1f7,0x3f6 on irq 14

the addresses are very different, however this could just be because the ppc
uses a very different address space model or some such.

I just compiled the 2.2.10 kernel I am using and I left out pci ide support,
but it has the built in powermac ide support still selected, so this could
be the problem. It has been a long time since I had 2.2.10 on this powermac
last so I dont have my old .configs around anymore.

Anyway once I have found a way to make the thing get past this point in the
kernel booting, I will have to start going through the kernels from 2.2.10
up and see which do and dont work. Now for that I need some way to get the
different revisions. Are there any places other than bitkeeper that will let
me do this? like a cvs tree? Paulus' rsync I dont think will let me get
anything but the latest version that he has up there.

Also should I maybe try out 2.2.4someversion ?

	See You
	    Steve

--
sjh@wibble.net http://wibble.net/~sjh/
Look Up In The Sky
   Is it a bird?  No
      Is it a plane?  No
         Is it a small blue banana?
YES

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
