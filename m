Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 7FCBB67B32
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Jul 2006 09:35:57 +1000 (EST)
Date: Tue, 18 Jul 2006 16:35:54 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Parav Pandit <paravpandit@yahoo.com>
Subject: Re: page locking in PowerPC cores
Message-ID: <20060718233554.GA27549@gate.ebshome.net>
References: <20060718110350.28445.qmail@web36614.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060718110350.28445.qmail@web36614.mail.mud.yahoo.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Jul 18, 2006 at 04:03:50AM -0700, Parav Pandit wrote:
> Hi,
>    
>   We allocate memory for DMA operation on PCI device using pci_alloc_constistent().
>    
>   I want to know how this function is boil down to the actual instruction which locks the page in the RAM so that it cannot be paged out and dma can do its work.

This is trivial - you can start with looking at the implementation.

>    
>   Can anybody tell me which instructions do we use to set this page entry in TLB and page table?
>   What bit gets set in the PTE for this?

Why do you need this page in TLB?

In general you don't have to worry about _any_ memory you allocated in 
the kernel to be paged out.

-- 
Eugene
