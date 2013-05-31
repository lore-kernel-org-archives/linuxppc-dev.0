Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2D44D2C02BB
 for <linuxppc-dev@ozlabs.org>; Fri, 31 May 2013 20:00:15 +1000 (EST)
Message-ID: <1369994404.3928.131.camel@pasglop>
Subject: Re: can't access PCIe card under sbc8548
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Date: Fri, 31 May 2013 20:00:04 +1000
In-Reply-To: <1369931094.14679.6@snotra>
References: <1369931094.14679.6@snotra>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: wolfking <wolfking2000@msn.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-05-30 at 11:24 -0500, Scott Wood wrote:
> ioremap() and out_bex/in_bex are not appropriate for PCI I/O regions  
> (and presumably that's what it is, if pci_iomap is calling  
> ioport_map).  Big-endian is not appropriate for PCI in any case.
> 
> The whole point of pci_iomap() appears to be that the driver doesn't  
> need to care whether it's MMIO or PIO, and can use ioread/writeX on the  
> resulting cookie.  If PPC is messing this up it's not the driver's  
> fault.

We are not messing this up and it should work.

Cheers,
Ben.
