Message-ID: <B164B53F5BD6D511888D009027732E1A024972@ntserver.act.domain>
From: Rudolf Ladyzhenskii <rudolf.ladyzhenskii@act-aus.net>
To: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: request_irq () kills kernel
Date: Thu, 22 Nov 2001 11:32:58 +1100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, all

I am writing a driver to support MPC8260 hardware timers.
The very moment I call request_irq(), kernel dies without a warning (I use
2.4.4 kernel).

I was looking through the kernel code and I discovered that other drivers
use request_8xxirq() instead of request_irq(). Now, those things have been
defined to be same in /arch/ppc/kernel/irq.c, but both appear in System.map.
Which one should I use?
Also, anyone have any ideas why kernel would die?
I am trying to hook to interrupt 0x0c (Timer0) and I checked SIMR_L register
to make sure Timer interrupts are masked.

Thanks,
Rudolf


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
