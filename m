Date: Fri, 6 Jun 2003 14:29:39 -0400
From: Kent Borg <kentborg@borg.org>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Why ack interrupt before calling handler?
Message-ID: <20030606142939.B15725@borg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am confused by something in ppc_irq_dispatch_handler().  It looks to
me that the interrupt is ack-ed before the handler is called.  Maybe I
am misunderstanding, but doesn't the ack only reset the interrupt
controller?  If so, the interrupting hardware could still be
presenting a level-triggered interrupt.  Wouldn't it make more sense
to let the interrupt routine get service the hardware first, then
reset the interrupt controller?

Thanks,

-kb

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
