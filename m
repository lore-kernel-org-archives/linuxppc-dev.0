Mime-Version: 1.0
Message-Id: <v04220802b504667b9953@[192.168.0.2]>
Date: Mon, 27 Mar 2000 02:38:10 +0100
To: linuxppc-dev@lists.linuxppc.org
From: "Michael A. Peters" <mpeters@mac.com>
Subject: compiling glibc
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm having trouble compiling glibc-2.1.3

I grabbed the source from ftp.gnu.org and added the linux-threads and
crypt add ons. I am building the source from a seperate directory.

When I give the make command, it chews away for awhile- and the exits
with parsing errors on line 379 and 382 of C-ctype.c (in
glibc-2.1.3/locale/)

Those lines are at the very end of that file, but I didn't see any
obvious problem with that file.

I've looked and looked and looked in the FAQ included with the
source, and I can't seem to find the problem.

I'm running LinuxPPC 2000 Lite with all the development packages
added (mostly from fswirl) including

gcc-2.95.2-1i
glibc-2.1.3-5a/glibc-devel-2.1.3-5a
binutils-2.9.5.0.19-0a

My kernel is a 2.2.14 kernel from ftp.kernel.org with the 2.3.50-usb
backport patch, rage128 patch, and mol patch before building.

I've had no problems compiling other stuff, such as gcc-2.95.2 or
binutils-2.95.2-29 from source. I just can't seem to get glibc-2.1.3
to completely build, always giving the parse errors mentioned above
when it quits.

I would appreciate any tips- I'm trying to apply the Linux From
Scratch project and, well, this is what I'm stuck on at the moment...

Thanks, Michael

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
