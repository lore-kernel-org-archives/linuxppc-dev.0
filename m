Return-Path: <Bruce_Leonard@selinc.com>
Received: from tesla.selinc.com (tesla.selinc.com [12.110.71.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "tesla.selinc.com", Issuer "RSA Data Security,
	Inc." (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 010CBDDDE7
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Nov 2008 13:44:47 +1100 (EST)
Received: from edison2.selinc.com (edison2.selinc.com [12.110.71.8])
	by tesla.selinc.com (8.12.11.20060308/8.12.11) with ESMTP id
	mA627NdI002247
	for <linuxppc-embedded@ozlabs.org>; Wed, 5 Nov 2008 18:07:29 -0800
To: linuxppc-embedded@ozlabs.org
Subject: Using DMA
MIME-Version: 1.0
Message-ID: <OF1BC63DE0.D024D14C-ON882574F9.000ABAA9-882574F9.000BA2A1@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Wed, 5 Nov 2008 18:07:20 -0800
Content-Type: text/plain; charset="US-ASCII"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This may be the wrong forum for this question.  If so I apologize, and 
could someone please tell me the appropriate place to ask?

Assuming this is the right place, I'm working with the 2.6.27 (stable) 
kernel and an MPC8347E processor.  I'm using a custom NAND controller and 
a custom driver to talk with that controller.  I'm now to the point where 
I'm trying to optimize/improve performance and something I'd like to do is 
set up the driver to use DMA transfers to the controller.  (As an 
additional bit of info, I modeled my driver on the Cafe driver.)  However, 
no one here has ever had to set up DMA from scratch before, it's always 
been done by an existing driver or the kernel, so I'm in uncharted 
teritory.

In the Cafe driver, Linux Device Drivers 3rd Edition, and DMA-mapping.txt 
everyone talks about how to allocate buffers using 
dma/pci_alloc_coherent(), but no one talks about how to actually use it. 
I'm pretty sure (even in my ignorance) that just allocating a DMA coherent 
buffer and then copying in and out of it does NOT actually engage the 
underlying hardware and perform a DMA transfer.

With some digging I've found the Freescale Elo/Elo Plus DMA driver which 
supports my processor.  What I'm not clear on is how to actually make use 
of it.  How do I tie my NAND driver to the Freescale DMA driver and 
actually get the hardware to work?  Any pointers are greatly appreciated.

Thanks.

Bruce
