Return-Path: <wolfking2000@msn.com>
Received: from sam.nabble.com (sam.nabble.com [216.139.236.26])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id ECEFB2C0091
 for <linuxppc-dev@ozlabs.org>; Thu, 30 May 2013 17:19:31 +1000 (EST)
Received: from tom.nabble.com ([192.168.236.105])
 by sam.nabble.com with esmtp (Exim 4.72)
 (envelope-from <wolfking2000@msn.com>) id 1Uhx8z-0003Ib-Pu
 for linuxppc-dev@ozlabs.org; Thu, 30 May 2013 00:19:29 -0700
Date: Thu, 30 May 2013 00:19:29 -0700 (PDT)
From: wolfking <wolfking2000@msn.com>
To: linuxppc-dev@ozlabs.org
Message-ID: <1369898369690-71782.post@n7.nabble.com>
In-Reply-To: <51A6EA1D.7080100@windriver.com>
References: <1369885321567-71775.post@n7.nabble.com>
 <51A6EA1D.7080100@windriver.com>
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

hi, tiejun.chen:
  Thanks for replying.
  I tried to use ioremap too, but it doesn't work. The ioport_map method
succeeded
under mpc8641d which is also a ppc.
  In fact, I also tried using pci_iomap by imitating rtl8139's codes. The
rtl8139's BAR0 
is also a I/O mapped register and its code succeeded in accessing its
registers by 
using pci_iomap under sbc8548. But when I used pci_iomap for my PCIe card,
its
output is just the same with the method of using ioport_map. Any suggestion?



--
View this message in context: http://linuxppc.10917.n7.nabble.com/can-t-access-PCIe-card-under-sbc8548-tp71775p71782.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
