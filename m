Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3232FDDE9D
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2007 02:24:35 +1000 (EST)
Message-ID: <46B9EE34.9000003@freescale.com>
Date: Wed, 08 Aug 2007 11:24:20 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Alexandros Kostopoulos <akostop@inaccessnetworks.com>
Subject: Re: pci in arch/powerpc vs arch/ppc
References: <op.twhnwi18nhx3hy@phoenix>
	<20070803201036.GA18229@ld0162-tx32.am.freescale.net>
	<F081E320-CFF9-497C-87D5-50E2E5C15A24@kernel.crashing.org>
	<op.twol4cixnhx3hy@phoenix> <46B88DAC.70005@freescale.com>
	<op.twqn4vtsnhx3hy@phoenix> <op.twqrwwx2nhx3hy@phoenix>
In-Reply-To: <op.twqrwwx2nhx3hy@phoenix>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Alexandros Kostopoulos wrote:
>> Well, the error message is:
>> PCI:0000:00:16.0: Resource 0: 0000000000000000-0000000000000fff (f=200)
>> PCI: Cannot allocate resource region 0 of device 0000:00:16.0
>> PCI:  parent is c03c4058: 0000000080000000-00000000bfffffff (f=200)
[snip]
> Oops, I think I found it. I think resources are allocated properly in  
> pci_assign_resource(), and you were probably talking about the PCI 
> device  BAR, not the host bridge POBARs, right. So the error message in 
> my  previous mail is the one you say it's ok?

Yes.

-Scott
