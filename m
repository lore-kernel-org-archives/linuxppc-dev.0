Date: Thu, 08 May 2003 17:48:02 -0400
From: Kent Borg <kentborg@borg.org>
Subject: Re: Shared Interrupts Question (2.4)
To: Dale Farnsworth <dale@farnsworth.org>,
	linuxppc-embedded@lists.linuxppc.org
Message-id: <2.1-12682897-381-A-OEWW@smtp.sprintpcs.com>
MIME-version: 1.0
Content-type: text/plain; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dale Farnsworth wrote:
> Create and register a board-specific interrupt driver.  Assign it
> a range of irqs (non-conflicting with the main interrupt driver).
> When called with an irq outside its range, the board-specific driver
> routines forward the call to the main driver.  The board-specific driver
> does a request_irq at init time for the one main irq it is multiplexing.

Yes!  Flatten the cascaded interrupts to IRQs outside the CPU's, range,
and write a software multiplexer that registers for the one IRQ the CPU
knows. Right?

That's much better than what I had in mind.


Thanks,

-kb

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
