Mime-Version: 1.0
Message-Id: <p06100213bc62d581deab@[192.168.9.138]>
Date: Wed, 25 Feb 2004 18:02:27 -0500
To: linuxppc-dev@lists.linuxppc.org
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: can't compile kernel for MPC8xx
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Host system is iBook running 2.4.24-ben on YDL 3.0.1:
	binutils-2.13.90.0.18-6
	gcc-3.2.2-2a
	glibc-2.3.1-51a

Target build is kernel.org 2.4.22, with linuxppc-2.4.22.patch applied.

Processor type set to 8xx, math emulation turned ON.

MPC8xx CPM options set to CPM SCC Ethernet

I get build errors galore. Eliminated one set of errors by removing
all framebuffer support, another set of errors disappeared by
removing all 10/100 network device support. This is a brightstar box
so it makes sense to have no framebuffer and maybe no ethernet, but
now I'm getting errors in 8xx_io. Something smells. There can't be
that many things to turn off without me seeing reference to it
somewhere.

So I have this question inspired by

<http://penguinppc.org/embedded/howto/x321.html>

The page notes that *binaries* must be dynamically linked, glibc must
be rebuilt with -mhard-float, and math emulation must be included.
I'm assuming that since I have emulation turned on in the kernel
config I'm OK on that one, but what about the other - does
"dynamically link binaries" also refer to the kernel itself? Is that
why I have so many error bundles trying to compile this?


Stefan Jeglinski


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
