Subject: PCI DMA support on the MPC8250
From: Jim Rowe <rowejames@acmsystems.com>
To: linuxppc-embedded@lists.linuxppc.org
Message-Id: <1056478960.8336.24.camel@kneedragger>
Mime-Version: 1.0
Date: 24 Jun 2003 11:22:40 -0700
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I'm working with a custom 8250 board that has a 1394 OHCI chip. OHCI
requires DMA transfers. I didn't see any support in the latest PPC tree
for the DMA features of the 8250's PCI Controller. Is DMA working on the
MPC8250?


--
Jim Rowe
Advanced CounterMeasure Systems
Phone: (916)669-4304
Email: jrowe@acmsystems.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
