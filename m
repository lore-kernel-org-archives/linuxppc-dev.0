Message-ID: <4418.62.48.238.11.1086803257.squirrel@alumni.deec.uc.pt>
Date: Wed, 9 Jun 2004 18:47:37 +0100 (WEST)
Subject: U-Boot and kernel 2.6
From: "Ricardo DIz" <rdiz@alumni.deec.uc.pt>
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I'm trying to boot a custom 860T board using the latest kernel from
linuxppc-2.5. The board is currently using a variation of an old version
of U-Boot (0.2.0) along with a hacked 2.4.20 linux kernel version.

My first aim is to boot a simple kernel and make it get to a shell. For
that I compiled the kernel, but did not compiled u-boot with a recent
version.

When booting, the kernel got uncompressed, but then it resets! I presume
the watchdog (which is enabled), is resetting the processor, so I guess
booting just stalls. Was there any changes in the way parameters were
received by the kernel since 2.4.20?

Oh, I forgot to mention the compiler. I'm still using a gcc 2.95
cross-compiler, altough I tried using a gcc 3.2 cross-compiler for the
8260 once, but got the same result.

I followed a recent thread very similar to this, but that turned out to be
just a matter of UART configuration, and I don't thinks this is the case.

Any thoughts?

Thanks in advance,
Ricardo Diz

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
