Return-Path: <Bruce_Leonard@selinc.com>
Received: from tesla.selinc.com (tesla.selinc.com [12.110.71.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "tesla.selinc.com", Issuer "RSA Data Security,
	Inc." (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1FAC6DDEE8
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Nov 2008 08:00:38 +1100 (EST)
In-Reply-To: <4913394A.9040103@billgatliff.com>
To: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: Using DMA
MIME-Version: 1.0
Message-ID: <OF4C3103D2.DABB64DF-ON882574F9.00733B0E-882574F9.00733B48@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Thu, 6 Nov 2008 12:58:53 -0800
Content-Type: text/plain; charset="US-ASCII"
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Bill Gatliff <bgat@billgatliff.com> wrote on 11/06/2008 10:36:58 AM:

> Scott Wood wrote:
> > Bruce_Leonard@selinc.com wrote:
> >> In the Cafe driver, Linux Device Drivers 3rd Edition, and
> >> DMA-mapping.txt everyone talks about how to allocate buffers using
> >> dma/pci_alloc_coherent(), but no one talks about how to actually use
> >> it. I'm pretty sure (even in my ignorance) that just allocating a DMA
> >> coherent buffer and then copying in and out of it does NOT actually
> >> engage the underlying hardware and perform a DMA transfer.
> 
> Does the "adma" stuff address this any?
> 

What is "adma"?

Bruce
