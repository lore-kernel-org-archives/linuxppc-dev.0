Message-ID: <38E3CE55.977E302@cray.com>
Date: Thu, 30 Mar 2000 15:59:49 -0600
From: Mike Wolf <mwolf@sgi.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: 4xx tlb questions
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
  I'm new to kernel development and have a question
on the 4xx.  Part of the tlb address is 8 bits from the
PID register.  I cannot find the code that sets the PID
register for user code.  I find code that sets the PID reg
to 0, and I find code that saves the current value of PID reg
and then setting it to 0 to do some work and then sets
it back.  I was expecting to see something in sched.c that
set the PID to some value from the task_struct on a context
switch.

Its not at all obvious to me how the PID is getting set.  The
only other option I'm aware of is to invalidate the TLB on
a context change, but I didnt see that either and the tlb
handlers imply something else because they save the current
value of the PID register.  If it was always 0 it wouldnt
need that
--
Mike Wolf
Cray Research
655-F Lone Oak Drive, Eagan, MN 55121
mwolf@cray.com          (651)683-5313

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
