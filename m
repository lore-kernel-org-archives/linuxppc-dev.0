Return-Path: <bgat@billgatliff.com>
Received: from venus.billgatliff.com (venus.billgatliff.com [209.251.101.201])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C721ADDF53
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Nov 2008 05:36:58 +1100 (EST)
Message-ID: <4913394A.9040103@billgatliff.com>
Date: Thu, 06 Nov 2008 12:36:58 -0600
From: Bill Gatliff <bgat@billgatliff.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: Using DMA
References: <OF1BC63DE0.D024D14C-ON882574F9.000ABAA9-882574F9.000BA2A1@selinc.com>
	<49133792.9080000@freescale.com>
In-Reply-To: <49133792.9080000@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Bruce_Leonard@selinc.com, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:
> Bruce_Leonard@selinc.com wrote:
>> In the Cafe driver, Linux Device Drivers 3rd Edition, and
>> DMA-mapping.txt everyone talks about how to allocate buffers using
>> dma/pci_alloc_coherent(), but no one talks about how to actually use
>> it. I'm pretty sure (even in my ignorance) that just allocating a DMA
>> coherent buffer and then copying in and out of it does NOT actually
>> engage the underlying hardware and perform a DMA transfer.

Does the "adma" stuff address this any?


b.g.
-- 
Bill Gatliff
bgat@billgatliff.com
