Message-ID: <3FA8C69D.8040408@mixed-mode.de>
Date: Wed, 05 Nov 2003 10:45:01 +0100
From: Tamas Bara <tba@mixed-mode.de>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: PCI on TQM8265
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I have a TQM8265 kit with Linux 2.4.4 on it and an
Intel Gigabit Ethernet controller connected to the
PCI bus.

The controller is working, but it does freeze Linux
on high network load.

I have found out that in the 60x Bus Transfer Error
Status and Control Register 1 (TESCR1), the PCI
Machine Check bit is always set.

The description in the user manual is very short:

Set when a core machine check is asserted from the
PCI bridge.

I would like to know what causes this bit to be set.

Thanks

- tamas


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
