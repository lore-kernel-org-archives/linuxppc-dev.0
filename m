Date: Wed, 4 Feb 2004 10:40:17 +0100
From: Olaf Hering <olh@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Missing isa_ symbols
Message-ID: <20040204094017.GA7012@suse.de>
References: <20040203210321.GA19689@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20040203210321.GA19689@lst.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 On Tue, Feb 03, Christoph Hellwig wrote:

>
> I've recently switched CONFIG_ISA on to compile-test various scsi
> drivers and get lots of warnings like:
>
> WARNING: /lib/modules/2.6.2-rc3/kernel/drivers/scsi/wd7000.ko needs unknown symbol isa_bus_to_virt
> WARNING: /lib/modules/2.6.2-rc3/kernel/drivers/scsi/wd7000.ko needs unknown symbol isa_page_to_bus
> WARNING: /lib/modules/2.6.2-rc3/kernel/drivers/scsi/wd7000.ko needs unknown symbol isa_virt_to_bus
> WARNING: /lib/modules/2.6.2-rc3/kernel/drivers/scsi/wd7000.ko needs unknown symbol udelay

Who is using that kind of hardware on ppc32?

--
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
