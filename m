From: kd@flaga.is
Subject: gdbserver
To: linuxppc-embedded@lists.linuxppc.org
Message-ID: <OFFF644F53.7F60D0CE-ON0025684E.0050176B@flaga.is>
Date: Tue, 21 Dec 1999 14:35:31 +0000
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I am trying to get gdbserver to run on my mpc823 board. (The precompiled
gdbserver is not working for me, it does not seem to get argc and argv
correctly into main() and always terminates with "usage info".

Using the vanilla gdb-4.18 is of no use, since it has not support for ppc.
Using the gdbserver source that Dan posted here a few weeks back results in
the
the following undefined symbols,
PTRACE_POKEUSR
PTRACE_PEEKUSR
KERNEL_U_ADDR
when compiling low-linux.c
If I define these symbols to 6, 3 and 0 respectively, everything compiles
fine, but the linker fails with the error,
undefined referenve to REGISTER_U_ADDR in function register_addr.

These are defined (for some of the other targets) in directory gdb/config/.
Any idea what is missing?

K.D.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
