Return-Path: <arieswar24b@yahoo.de>
Received: from web24106.mail.ird.yahoo.com (web24106.mail.ird.yahoo.com
	[87.248.114.170]) by ozlabs.org (Postfix) with SMTP id C8B9ADDEDA
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Mar 2009 00:33:46 +1100 (EST)
Message-ID: <538696.45538.qm@web24106.mail.ird.yahoo.com>
Date: Fri, 6 Mar 2009 13:27:05 +0000 (GMT)
From: Dave Best <arieswar24b@yahoo.de>
Subject: Interrupt GPIOs with MPC5200b
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Reply-To: arieswar24b@yahoo.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi, I am working on a MPC5200B-tiny with 2.6.23.1 Linux (pcm030).

I want to use an interrupt GPIO to act as the source for my ISR, but i can'=
t find the IRQ numbers for the GPIOs so i can't call request_irq() to set m=
y ISR up. =20

For other platforms there seems to be the function gpio_to_irq() where enum=
erated GPIOs get an IRQ number for their request_irq calls.

Any help or hints appreciated.

Dave=0A=0A=0A      
