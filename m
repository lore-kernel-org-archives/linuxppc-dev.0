Message-ID: <009501c37dba$0f462470$c50aa8c0@ksshin>
From: =?ks_c_5601-1987?B?vcWw5rz2?= <ksshin@essetel.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: PCI DMA in GT64260
Date: Thu, 18 Sep 2003 16:54:15 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear all.

I have a board that consisted of mpc7410+gt64260+pci_device,
and I have already success to read/write the pci_device.
After init the pci_device, I command to the pci_device
that read data from main memory(sdram),
but, the pci_device does not operate and return only fail...

I think that this is the DMA Problem...
so I want to know that how to set the register of gt64260 to do
DMA operation.

I already set PCI SCS[0] Size Reg, PCI SCS[0] Base Addr Remap Reg,
and PCI Base Address Enable Reg. what I omitted? or ...

please help me...

Thanks everybody.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
