Message-ID: <40B595F7.3080801@fh-landshut.de>
Date: Thu, 27 May 2004 09:17:11 +0200
From: Oliver Korpilla <okorpil@fh-landshut.de>
Reply-To: okorpil@fh-landshut.de
MIME-Version: 1.0
To: Eugene Surovegin <ebs@ebshome.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ioremap() question
References: <40B4AB27.5020202@fh-landshut.de> <20040526171234.GA4255@gate.ebshome.net>
In-Reply-To: <20040526171234.GA4255@gate.ebshome.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Eugene Surovegin wrote:

>You cannot use virt_to_bus() on ioremap returned addresses.
>
>Eugene.
>
>
>
Hello!

Maybe I may go like this:

I know my PCI from the device bus, so:

unsigned long bus_address;
struct pci_bus *my_bus = universe_pci_dev->bus;
bus_address = pci_phys_to_bus(physical_address, my_bus->number);

Since pci_phys_to_bus() is an exported symbol, this should work in my
module, shouldn't it?

Thanks in advance,
Oliver Korpilla

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
