Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3BC55726.AAC2D093@imc-berlin.de>
Date: Thu, 11 Oct 2001 10:24:06 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: timebase_interrupts on MPC8xx ???
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi there,

I pulled linuxppc_2_4_devel yesterday, built and ran it on my MPC8xx
board.

Now I get load of

timebase_interrupt()
timebase_interrupt()
timebase_interrupt()

messages, which come from

/* A place holder for time base interrupts, if they are ever enabled. */
void timebase_interrupt(int irq, void * dev, struct pt_regs * regs)
{
	printk ("timebase_interrupt()\n");
}

in arch/ppc/kernel/m8xx_setup.c.

I've never seen them before, so I guess they were never enabled.
Are they enabled now? Why? Hardly just for making noise! ;-)

Cheers,

Steven Scholz

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
