Date: Tue, 3 Feb 2004 22:03:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: Missing isa_ symbols
Message-ID: <20040203210321.GA19689@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've recently switched CONFIG_ISA on to compile-test various scsi
drivers and get lots of warnings like:

WARNING: /lib/modules/2.6.2-rc3/kernel/drivers/scsi/wd7000.ko needs unknown symbol isa_bus_to_virt
WARNING: /lib/modules/2.6.2-rc3/kernel/drivers/scsi/wd7000.ko needs unknown symbol isa_page_to_bus
WARNING: /lib/modules/2.6.2-rc3/kernel/drivers/scsi/wd7000.ko needs unknown symbol isa_virt_to_bus
WARNING: /lib/modules/2.6.2-rc3/kernel/drivers/scsi/wd7000.ko needs unknown symbol udelay

from looking at other architectures it looks like architectures
supporting CONFIG_ISA are supposed to supply them.  Any idea how to
implement this properly for ppc?  (and no, I can't test it, by mac
doesn't actually have an isa bus)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
