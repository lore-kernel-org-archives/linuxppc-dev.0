Date: Wed, 28 Feb 2001 15:41:41 -0500 (EST)
From: Rod Stewart <stewart@dystopia.lab43.org>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: glibc mainline, which compiler?
Message-ID: <Pine.LNX.4.33.0102281519410.7051-100000@dystopia.lab43.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

I was wondering if a anyone knows what the minimum version of GCC is
needed to build the latest glibc mainline.

Currently I have:
	Running: 'Linux/PPC 2000 Q4', which has
	[stewart@smac stewart]$ rpm -q binutils glibc gcc
	binutils-2.10.1.0.2-0a
	glibc-2.1.3-15f
	gcc-2.95.3-2n

Do I need to use the mainline GCC to build glibc 2.2.x?

I can build gcc, binutils, and gdb fine.  I just need to get glibc going
for http://www.netwinder.org/build stuff and I can add in PPC fully.

Thanks for any tips,
-Rms


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
