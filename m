Date: Mon, 22 Oct 2001 16:21:18 -0400
From: Kent Borg <kentborg@borg.org>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Dying of First sti()
Message-ID: <20011022162118.A13160@borg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have been trying to move work from an old Linux PPC kernel to a
current (rsync-ed from source.mvista.com::linuxppc_2_4_devel) kernel
tree.  I have a 405GP on a custom board.

In this effort I am getting some output on the serial port, I make it
in init/main.c to the point where sti() is about to be called.  But I
never get back from the sti() call.

Early in the boot I turned off all interrupt sources.  Using RISC
Watch I can (laboriously) trace through timer_interrupt(), and I am
not caught in an infinite loop in there, it does return.

I am thinking our limited boot ROM isn't setting up everything the
kernel expects.

Ideas?


Thanks,

-kb

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
