Date: Wed, 5 Sep 2001 18:16:54 -0400
Message-Id: <200109052216.f85MGsi32749@hyper.wm.sps.mot.com>
From: Peter Barada <pbarada@mail.wm.sps.mot.com>
To: elan@nxnetworks.com
Cc: linuxppc-embedded@lists.linuxppc.org
In-reply-to: <NDBBLJKOJGKDOFBHNPGEMENACEAA.elan@nxnetworks.com>
Subject: Re: Cross GDB and core files
References: <NDBBLJKOJGKDOFBHNPGEMENACEAA.elan@nxnetworks.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>I'm trying to get gdb compiled with host of 386-linux and target of
>ppc-linux, mostly for debugging core files.  The ppc_8xx-gdb that came with
>hardhat doesn't work, when I run it on a core file I get:
>
>And if I try to build gdb from scratch using
>"./configure --target=ppc-linux" I get a cross gdb that has no clue how to
>read PPC ELF core files.

I've had luck building gdb-5.0 for powerpc-linux and used it to
debug a PPC linux kernel via a serial port, as well as use it (in
conjunction with gdbserver) to debug application code over the
network.  I used the following to configure:

../gdb-5.0/configure --target=powerpc-linux

--
Peter Barada                                   Peter.Barada@motorola.com
Wizard                                         781-852-2768 (direct)
WaveMark Solutions(wholly owned by Motorola)   781-270-0193 (fax)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
