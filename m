Date: Mon, 12 Jun 2000 13:14:48 -0400 (EDT)
From: Ken Maier <kpm@pt.com>
Message-Id: <200006121714.NAA11767@notes1.pt.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: interrupt handler and gnu
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


How do I get the gnu compiler to save processor state for a interrupt handler?
I have tried #pragma interrupt but it didn't work.  I'm compiling for the 8260
pqII.  I have started writing the code myself.  Do I need to save the fp regs?
Any help will be welcomed.

Thanks,
Ken Maier

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
