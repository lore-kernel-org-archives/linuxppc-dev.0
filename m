Date: Mon, 22 Jan 2001 13:42:26 +0100
From: Uwe Steinmann <steinm@majestix.fernuni-hagen.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: pcmcia on pismo: PCI irq 58 test failed
Message-ID: <20010122134226.A7757@gehtnix.fernuni-hagen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I'm trying to make pcmcia 3.1.22 support work on a pismo with
kernel 2.2.18-pre17-ben1. I was able to talk to a serial model card
but ran into problems with an AVM fritz!card though the necessary patch
for this card has been applied to the pcmcia package.

By looking at the syslog messages I feel like the problem is rather caused
by the pcmcia support than by this particular pcmcia card.
In the syslog I found a message

Jan 19 20:33:06 pb kernel:     PCI irq 58 test failed

which somewhat bother me.

Is this a proper behaviour? Could this be the reason that the avm pcmcia card
cannot request an irq?

In case the other related syslog messages are relevant, they are below.

Thanks for any help

  Uwe

Jan 19 20:33:06 pb kernel: Linux PCMCIA Card Services 3.1.22
Jan 19 20:33:06 pb kernel:   kernel build: 2.2.18pre17-ben1 #1 Fri Nov 3 11:06:07 CET 2000
Jan 19 20:33:06 pb kernel:   options:  [pci] [cardbus]
Jan 19 20:33:06 pb kernel: Intel PCIC probe:
Jan 19 20:33:06 pb kernel:   TI 1211 rev 00 PCI-to-CardBus at slot 00:1a, mem 0x80080000
Jan 19 20:33:06 pb kernel:     host opts [0]: [serial pci & irq] [pci irq 58] [lat 16/32] [bus 1/1]
Jan 19 20:33:06 pb kernel:     PCI irq 58 test failed
Jan 19 20:33:06 pb kernel:     *NO* card interrupts, polling interval = 1000 ms
Jan 19 20:33:06 pb cardmgr[926]: starting, version is 3.1.22
Jan 19 20:33:06 pb cardmgr[926]: watching 1 sockets
Jan 19 20:33:42 pb cardmgr[926]: initializing socket 0
Jan 19 20:33:42 pb kernel: cs: memory probe 0x80000000-0x80ffffff: excluding 0x80000000-0x800fffff
Jan 19 20:33:42 pb cardmgr[926]: socket 0: AVM Fritz! Card
Jan 19 20:33:42 pb cardmgr[926]: executing: 'modprobe hisax type=26'
Jan 19 20:33:42 pb kernel: ISDN subsystem Rev: 1.111/1.84/1.114/1.63/none/1.5 loaded
Jan 19 20:33:42 pb cardmgr[926]: executing: 'modprobe avma1_cs'
Jan 19 20:33:42 pb kernel: avma1_cs: testing i/o 0x140-0x149
Jan 19 20:33:42 pb kernel: avma1_cs: RequestIRQ: Resource in use
Jan 19 20:33:42 pb cardmgr[926]: get dev info on socket 0 failed: Kein passendes Gerät gefunden
--
  Uwe.Steinmann@fernuni-hagen.de
  Tel: +2331 987 4528    Fax: +2331 987 375

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
