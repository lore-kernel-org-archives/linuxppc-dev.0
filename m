Subject: Re: Missing isa_ symbols
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040203210321.GA19689@lst.de>
References: <20040203210321.GA19689@lst.de>
Content-Type: text/plain
Message-Id: <1075847130.17316.33.camel@gaston>
Mime-Version: 1.0
Date: Wed, 04 Feb 2004 09:25:30 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 2004-02-04 at 08:03, Christoph Hellwig wrote:
> I've recently switched CONFIG_ISA on to compile-test various scsi
> drivers and get lots of warnings like:
>
> WARNING: /lib/modules/2.6.2-rc3/kernel/drivers/scsi/wd7000.ko needs unknown symbol isa_bus_to_virt
> WARNING: /lib/modules/2.6.2-rc3/kernel/drivers/scsi/wd7000.ko needs unknown symbol isa_page_to_bus
> WARNING: /lib/modules/2.6.2-rc3/kernel/drivers/scsi/wd7000.ko needs unknown symbol isa_virt_to_bus
> WARNING: /lib/modules/2.6.2-rc3/kernel/drivers/scsi/wd7000.ko needs unknown symbol udelay

udelay is a different story, the driver probably lacks an include

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
