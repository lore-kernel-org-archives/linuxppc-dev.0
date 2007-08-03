Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 53F19DDE27
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Aug 2007 06:10:56 +1000 (EST)
Date: Fri, 3 Aug 2007 15:10:37 -0500
From: Scott Wood <scottwood@freescale.com>
To: Alexandros Kostopoulos <akostop@inaccessnetworks.com>
Subject: Re: pci in arch/powerpc vs arch/ppc
Message-ID: <20070803201036.GA18229@ld0162-tx32.am.freescale.net>
References: <op.twhnwi18nhx3hy@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <op.twhnwi18nhx3hy@phoenix>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 03, 2007 at 05:58:56PM +0300, Alexandros Kostopoulos wrote:
> Hi all,
> in the old arch/ppc tree, there was a function called pq2ads_setup_pci()  
> that set up PCI regs for 8272xx, in m82xx_pci.c. I was wandering, where  
> are these registers configured now in arch/powerpc? I can't seem to find  
> these code now.

It's done by the firmware or the bootwrapper.

> Also, I can see that now bus 0, dev 0 (which I think represents the host  
> bridge, right?) is now excluded using pq2_pci_exclude_device, but it  
> wasn't in older code. Why is that?

The older code probably either excluded all host bridges by class, or
just lived with the error message that gets printed on boot.

-Scott
