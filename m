Message-ID: <407C065A.9010004@imc-berlin.de>
Date: Tue, 13 Apr 2004 17:25:14 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: kfree_skb on hard IRQ ???
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi there,

my HERMES-II drivers causes a lot of

Warning: kfree_skb on hard IRQ c38c2168

messages.

What do they mean?

A grep on kernel sources brought me

drivers/net/smc91111.c: .      12/15/00  Christian Jullien fix "Warning:
kfree_skb on hard IRQ"

drivers/net/smc9194.c: .      12/15/00  Christian Jullien fix "Warning:
kfree_skb on hard IRQ"

drivers/net/hamradio/yam.c: *       OK1ZIA 2.09.01  Fixed "kfree_skb on hard
IRQ"

net/core/skbuff.c:                      printk(KERN_WARNING "Warning:
kfree_skb on hard IRQ %p\n",


but I don't know how they fixed that...

Thanks!

--
Steven Scholz

imc Measurement & Control               imc Meﬂsysteme GmbH
Voltastr. 5                             Voltastr. 5
13355 Berlin                            13355 Berlin
Germany                                 Deutschland


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
