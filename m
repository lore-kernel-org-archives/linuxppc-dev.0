Date: Fri, 28 Jan 2000 15:06:45 -0500 (EST)
From: Pavel Roskin <pavel_roskin@geocities.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Best compiler/flags combination
Message-ID: <Pine.LNX.4.21.0001281444060.32290-100000@sunapee.transcept.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello!

I'm compiling stuff for RPX/Lite on a PowerMac running LinuxPPC. It turns
out that programs compiled with -O2 work correctly on PowerMac but not on
RPX. For example, libcrypt.a compiled with -O2 and linked with tinylogin
crashes when it's run on RPX.

However, if I use -Os, all programs work correctly. The only exception was
ld.so that I had to recompile without optimization.

I'm using egcs-1.1.2 and glibc-2.1.1 with patches from LinuxPPC (i.e. I
use their source RPM's).

The question is, what compiler is known to produce good code for embedded
PPC boards and what flags should be used? It is desireable that the
binaries still run on PowerPC.

Pavel Roskin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
