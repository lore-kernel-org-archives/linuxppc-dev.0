Message-Id: <v0313030fb3efcb9a9d0f@[192.168.1.1]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 30 Aug 1999 00:54:50 -0500
To: linuxppc-dev@lists.linuxppc.org
From: "David D. Kilzer" <ddkilzer@computer.org>
Subject: SMP support for Daystar 604e 200MHz dual-processor card
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Is anyone running LinuxPPC with a Daystart 604e 200MHz dual-processor card?

I've compiled 2.2.12 from CVS source, and the kernel oops with some sort of
MMU fault.  (I can print out the exact error if necessary.)

I've also compiled 2.3.15 from CVS source, but it doesn't even get past the
initial screen that ends with "booting...".

Both kernels had SMP support compiled in.  I have not tried compiling a
kernel without SMP.

I'm using BootX 1.1.3 with only my root partition (/dev/sdb9) defined.

I have a working MkLinux installation (using glibc 2.0) with the
pmac-utils-1.1.1-1a.ppc.rpm installed (rebuilt from source) that boots fine.

Any ideas?  I haven't tried adding debug code or perusing the source, yet,
but I expected this configuration to work out-of-the-box since Daystar and
Apple SMP cards are supposed to be essentially the same.

Thanks!

Dave


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
