Date: Thu, 8 May 2003 16:28:14 -0400
From: Kent Borg <kentborg@borg.org>
To: bhupinder sahran <bhup_sah@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Shared Interrupts Question (2.4)
Message-ID: <20030508162814.B18714@borg.org>
References: <20030508160856.A18714@borg.org> <20030508202012.37047.qmail@web41503.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030508202012.37047.qmail@web41503.mail.yahoo.com>; from bhup_sah@yahoo.com on Thu, May 08, 2003 at 01:20:12PM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, May 08, 2003 at 01:20:12PM -0700, bhupinder sahran wrote:
> SO in the do_irq routine u will have to read the
> interrupt controller registers & find out who has
> caused the interrupt & then invoke interrupt handler
> corressponding to the interrupt number.

Yes, but how do I enable the interrupt in the first place?  (Disable
too.)  I mean, I know how to set the bit, but where is the best place
to do so?  In the case of a serial port, I figure I could turn it on
in startup() in serial.c.  But then how do I know which of two
possible interrupts it is?  I could do something hacky, like look at
the UART address and infer from there, but that looks nasty...


Thanks,

-kb, the Kent who, if has to muck with existing kernel files, wants to
do so in an acceptable way.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
