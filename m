Reply-To: <zjzhou@newrocktech.com>
From: "John Zhou" <zjzhou@newrocktech.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Shall I use which IRQ as input parameter of this function?
Date: Fri, 15 Feb 2002 15:31:53 +0800
Message-ID: <000001c1b5f2$d7d88950$9f02a8c0@newrock2>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <200308131036.14144.david.jander@protonic.nl>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear all,

I have a device with interrupt pin connecting to MPC8250's IRQ0( nonmaskable interrupter ),  when I use function " request_8xxirq( IRQx, tem_interrupt, 0, "temp", dev) " to register IRQ, but I only find SIU_INT_IRQ1-SIU_INT_IRQ7 in file <asm/irq.h> and can't find SIU_INT_IRQ0.  Shall I use which IRQ as input parameter of this function?

Thanks in advance!
John Zhou

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
