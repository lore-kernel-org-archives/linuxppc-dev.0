Message-ID: <12D7C6A4.AE725CC6@india.infogain.com>
Date: Tue, 01 May 2001 18:08:35 +0530
From: ashish anand <ashisha@india.infogain.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: placing of ioremap ?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have one question regarding the placing of ioremap call
suppose i have done ioremap call inside the mm/init.c
for pci i/o or memory space ..and if this space is above
the ioremap_base i would be having the virtual address
equal to physical address

now i don't need to call ioremap inside the driver code
since the resources (either pci i/o or memory or both) that
i am supposed to give a particular card has already been
ioremapped by now
in case my bios has not done the resource allocation
i have to just write the proper values in PCI_BASE_ADDRESS
registers of that pci card. Am I Correct?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
