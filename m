Content-Type: text/plain;
  charset="iso-8859-1"
From: Freddy Lugo <wilfredo_lugo@hp.com>
Reply-To: wilfredo_lugo@hp.com
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: How programs generate software interrupts?
Date: Fri, 27 Jul 2001 14:33:24 -0400
MIME-Version: 1.0
Message-Id: <01072714332404.00961@oubao.prd.hp.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


	Hi All,

	Some time ago I posted a question about not getting any program output to
the serial port when the kernel reach user space.  After a lot of troubleshooting I am still
unable to get any program output to the serial port.

	I am using a 16C550 serial port, I checked the UART's  configuration one
by one and everything is ok.  My serial port driver has a IRQ assigned to it and when
a key is pressed on the keyboard console everything work as expected.  (Interrupts are
generated and the data is read from the UART register and printed to the console).
But I am unable to see any output from the program(s).  I tried different programs
(sash, yes, printf) and nothing.

	Right now I don't know what else to check.  How a program is supposed
to send output messages to the serial port?  AFAIK the program should generate an interrupt,
who is then handled by the scheduler, and then passed to the do_softirq routine who then is
supposed to call the driver bottom half to schedule the event on the task queue.  Am I correct?
If I am, that is not happening.

Any hints?

thanks in advance,

Freddy


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
