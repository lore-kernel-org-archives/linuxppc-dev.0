Subject: ISA DMA troubles
To: linuxppc-embedded@lists.linuxppc.org
From: "Philippe Villet" <philippe.villet@acterna.com>
Date: Mon, 16 Dec 2002 11:52:19 +0100
Message-ID: <OF1FCF66DE.7512F549-ONC1256C91.00391843@eng.eni.wago.de>
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We are using a custom board based on a 405GP processor with a PIIX4
Southbridge (providing a PCI to ISA bridge, a DMA controller, an interrupt
controller, ...)
A FDC37C78 floppy disk controller is connected to the ISA bus, use a DMA
and an interrupt line of the southbridge.
Kernel version is 2.4.17 (Monta vista HHL 2.1) -
When we perform WRITE operations to the floppy, dma data sent to the floppy
controller are corrupted.
I try some debug and i saw that when a corrupted data is sent, it was a
data from the previous dma transfer from the same address.
When i dump the memory (with BDI2000) at the end of the transfert,
everything is OK.
Does someone met this problem ? A cache pb ?
How can i go further to debug ?

READ operations seems OK.

Thanks for your help .
Philippe


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
