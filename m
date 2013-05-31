Return-Path: <wolfking2000@msn.com>
Received: from sam.nabble.com (sam.nabble.com [216.139.236.26])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 052C72C013D
 for <linuxppc-dev@ozlabs.org>; Fri, 31 May 2013 22:46:10 +1000 (EST)
Received: from tom.nabble.com ([192.168.236.105])
 by sam.nabble.com with esmtp (Exim 4.72)
 (envelope-from <wolfking2000@msn.com>) id 1UiOie-0007pN-G6
 for linuxppc-dev@ozlabs.org; Fri, 31 May 2013 05:46:08 -0700
Date: Fri, 31 May 2013 05:46:08 -0700 (PDT)
From: wolfking <wolfking2000@msn.com>
To: linuxppc-dev@ozlabs.org
Message-ID: <1370004368473-71874.post@n7.nabble.com>
In-Reply-To: <1369994474.3928.132.camel@pasglop>
References: <1369885321567-71775.post@n7.nabble.com>
 <1369931365.14679.7@snotra> <1369960818166-71847.post@n7.nabble.com>
 <1369994474.3928.132.camel@pasglop>
Subject: Re: can't access PCIe card under sbc8548
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

hi, Herrenschmidt
 Thanks for replying to this topic!

> That looks more like a HW error to me unless you are hitting completely 
> the wrong system addresses.
The HW is OK. If I plug this card into another ppc board: mpc86641-hpcn,
it works fine. 

> What would be useful would be to add printk's to check what exact 
> physical address pci_iomap ends up using and whether that matches 
> to the iobase_phys of the PCI bridge + the BAR value of the card.
Would you mind telling me at what position should I add the printk?
I can only print pci_iomap's return address which is mentioned in 
the previous mail, it is 0xfc7fc000. The following is part of the
linux boot message:

PCI host bridge /pcie@e000a000  ranges:
 MEM 0x00000000a0000000..0x00000000afffffff -> 0x00000000a0000000 
  IO 0x00000000e2800000..0x00000000ea7fffff -> 0x0000000000000000
/pcie@e000a000: PCICSRBAR @ 0xfff00000

 Is 0xe2800000 the iobase_phys of the PCI bridge?

So any suggestion is appreciated!

regards,
wolfking.




--
View this message in context: http://linuxppc.10917.n7.nabble.com/can-t-access-PCIe-card-under-sbc8548-tp71775p71874.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
