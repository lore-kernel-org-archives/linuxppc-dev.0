Message-Id: <6.0.1.1.0.20040506101234.01efbb50@192.168.2.1>
Date: Fri, 07 May 2004 10:02:27 +0200
To: linuxppc-embedded@lists.linuxppc.org
From: llandre <r&d2@dave-tech.it>
Subject: 405 interrupt inizialization
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have a couple of questions about interrupt initialization. I compared the
two platform-specific files for the 405EP and 405GPr processors.
The first one (evb405ep.c) does not initialize the ibm4xxPIC_InitSenses to
setup all the IRQ lines while the second one (sycamore.c) does. Both of
them define the function ppc405_map_irq to setup IRQ lines associated with
PCI slots.
My questions are:
1) Why does not evb405ep.c use ibm4xxPIC_InitSenses to initializes IRQs
(polarity, level/edge etc)?
2) In my understanding the function ppc405_map_irq is used to inform PCI
subsystem about PCI slots IRQ routing. Is it correct?



Thanx in advance,

llandre

DAVE Electronics System House - R&D Department
www.dave-tech.it


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
