Message-ID: <3B02AD71.804119E3@india.infogain.com>
Date: Wed, 16 May 2001 22:10:17 +0530
From: ashish anand <ashisha@india.infogain.com>
MIME-Version: 1.0
To: Amelia De Vivo <amelia.devivo@roma.quadrics.com>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Addressing PCI memory
References: <002f01c0dd5c$f64942e0$7a00000a@roma.quadrics.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Amelia De Vivo wrote:
>
> Hi all, I'm trying to write a driver for a 64 bit PCI device. Something like
> this works well under i386 Linux, but it doesn't work at all for Linux
> 2.2.15 by Yellow Dog:
>
>     struct pci_dev *dev = NULL;
>     dev = pci_find_device(vendor, device, dev);
>     pci_read_config_dword(dev, PCI_BASE_ADDRESS_0, &cards[0].addr0);
>     cards[0].vaddr = (void *) ioremap((cards[0].addr0 &
> PCI_BASE_ADDRESS_MEM_MASK), cards[0].size);
>     writeb('A',(cards[0].vaddr)+0x1000);

 READ PCI STATUS REGISTER TO CHECK FOR ANY MASTER/TARGET ABORT.
  LASTLY WHAT IS THE VALUE OF cards[0].size ?

> I have a kernel panic on writeb. Has someone some suggestion?

LET ME KNOW THE PANIC MESSAGE....

> Thanks in advance
>
> Amelia
>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
