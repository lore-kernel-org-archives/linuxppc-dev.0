Date: Wed, 27 Dec 2000 14:51:25 +0100
From: christophe barbe <christophe.barbe@inup.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: linux-2.2.18 
Message-ID: <20001227145125.A11036@pc8.inup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm working on a CompactPCI PowerPC card (MCPN750). I've written a little module which uses an IRQ which is simply registred with a request_irq call.
It works great with a patched kernel 2.2.17.
I try to upgrade to the last kernel release. Everything seems to be ok except that I never receive IRQ events.
I've tried to follow the irq path (from head.S, do_IRQ(), ppc_md.do_IRQ(), open_pic_do_IRQ(), ppc_irq_dispatch_handler() to
irq_desc[irq].action) and in my (limited) understanding it seems good but in fact I never go in the do_IRQ() function. It sounds like my irq is not hard-enabled.
(I can see it in /proc/interrupts)

I've seem that all the pending patches for ppc have beeb applied in 2.2.18. Is there in this patches something I should know to use my IRQ ?

Thanks,
Christophe


--

Christophe Barbé
Software Engineer
Lineo High Availability Group
42-46, rue Médéric
92110 Clichy - France
phone (33).1.41.40.02.12
fax (33).1.41.40.02.01
www.lineo.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
