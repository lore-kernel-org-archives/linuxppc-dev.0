Message-ID: <003d01c0ddf3$085edd00$7a00000a@roma.quadrics.com>
Reply-To: "Amelia De Vivo" <amelia.devivo@roma.quadrics.com>
From: "Amelia De Vivo" <amelia@roma.quadrics.com>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Re: Addressing PCI memory
Date: Wed, 16 May 2001 12:29:05 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


----- Original Message -----
From: ashish anand <ashisha@india.infogain.com>
To: Amelia De Vivo <amelia.devivo@roma.quadrics.com>;
<linuxppc-dev@lists.linuxppc.org>
Sent: Wednesday, May 16, 2001 6:40 PM
Subject: Re: Addressing PCI memory


> Amelia De Vivo wrote:
> >
> > Hi all, I'm trying to write a driver for a 64 bit PCI device. Something
like
> > this works well under i386 Linux, but it doesn't work at all for Linux
> > 2.2.15 by Yellow Dog:
> >
> >     struct pci_dev *dev = NULL;
> >     dev = pci_find_device(vendor, device, dev);
> >     pci_read_config_dword(dev, PCI_BASE_ADDRESS_0, &cards[0].addr0);
> >     cards[0].vaddr = (void *) ioremap((cards[0].addr0 &
> > PCI_BASE_ADDRESS_MEM_MASK), cards[0].size);
> >     writeb('A',(cards[0].vaddr)+0x1000);
>
>  READ PCI STATUS REGISTER TO CHECK FOR ANY MASTER/TARGET ABORT.

Thanks for your reply.
I read the pci status register and there wasn't any master/target abort

>   LASTLY WHAT IS THE VALUE OF cards[0].size ?

This is 0x2000000
>
> > I have a kernel panic on writeb. Has someone some suggestion?
>
> LET ME KNOW THE PANIC MESSAGE....

kernel panic: machine check
>
> > Thanks in advance
> >
> > Amelia

Bye Amelia
> >
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
