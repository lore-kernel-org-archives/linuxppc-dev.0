Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 468BDDDDF5
	for <linuxppc-dev@ozlabs.org>; Sun,  5 Aug 2007 02:39:04 +1000 (EST)
In-Reply-To: <20070803201036.GA18229@ld0162-tx32.am.freescale.net>
References: <op.twhnwi18nhx3hy@phoenix>
	<20070803201036.GA18229@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F081E320-CFF9-497C-87D5-50E2E5C15A24@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: pci in arch/powerpc vs arch/ppc
Date: Sat, 4 Aug 2007 11:39:58 -0500
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org,
	Alexandros Kostopoulos <akostop@inaccessnetworks.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 3, 2007, at 3:10 PM, Scott Wood wrote:

> On Fri, Aug 03, 2007 at 05:58:56PM +0300, Alexandros Kostopoulos  
> wrote:
>> Hi all,
>> in the old arch/ppc tree, there was a function called  
>> pq2ads_setup_pci()
>> that set up PCI regs for 8272xx, in m82xx_pci.c. I was wandering,  
>> where
>> are these registers configured now in arch/powerpc? I can't seem  
>> to find
>> these code now.
>
> It's done by the firmware or the bootwrapper.

>> Also, I can see that now bus 0, dev 0 (which I think represents  
>> the host
>> bridge, right?) is now excluded using pq2_pci_exclude_device, but it
>> wasn't in older code. Why is that?
>
> The older code probably either excluded all host bridges by class, or
> just lived with the error message that gets printed on boot.

This will change in 2.6.24.  I've fixed the reason we excluded the  
host bridges on Freescale host bridges.

- k
