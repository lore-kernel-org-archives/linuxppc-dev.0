Return-Path: <Matteo.Fortini@mta.it>
Received: from cluster-d.mailcontrol.com (cluster-d.mailcontrol.com
	[85.115.60.190])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.mailcontrol.com",
	Issuer "DigiCert Global CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 620CADDE0E
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 23:43:53 +1100 (EST)
Received: from mailserver.mta.int (mail.mta.it [89.96.171.250])
	by rly22d.srv.mailcontrol.com (MailControl) with ESMTP id
	n2BCBlXT020360
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 12:11:47 GMT
Message-ID: <49B7AA80.2030501@mta.it>
Date: Wed, 11 Mar 2009 13:11:44 +0100
From: Matteo Fortini <matteo.fortini@mta.it>
MIME-Version: 1.0
To: linux-ppc list <linuxppc-dev@ozlabs.org>
Subject: MPC512x DMA to PCI dev
Content-Type: text/plain; charset="ISO-8859-15"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,
I'm trying to send some data through DMA from a memory buffer to a PCI 
video card VRAM.

While I got that I need to alloc the src buffer through 
dma_alloc_coherent, I don't understand which address I should give as 
the dst address.

I tried both the mapped hw address and an address received from 
pci_map_single, but even if the DMA transfer completes "correctly", I 
have the wrong data in the VRAM in the end.

I read about all the PCI DMA manuals, but it seems they are for letting 
some external DMA device on the PCI bus read/write from/to the main memory.

How do you do that?

Thanks,
Matteo
