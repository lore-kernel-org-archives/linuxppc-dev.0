Return-Path: <bgat@billgatliff.com>
Received: from venus.billgatliff.com (venus.billgatliff.com [209.251.101.201])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AACB2DDFB7
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Nov 2008 08:42:17 +1100 (EST)
Message-ID: <491364B9.607@billgatliff.com>
Date: Thu, 06 Nov 2008 15:42:17 -0600
From: Bill Gatliff <bgat@billgatliff.com>
MIME-Version: 1.0
To: Bruce_Leonard@selinc.com
Subject: Re: Using DMA
References: <OF4C3103D2.DABB64DF-ON882574F9.00733B0E-882574F9.00733B48@selinc.com>
In-Reply-To: <OF4C3103D2.DABB64DF-ON882574F9.00733B0E-882574F9.00733B48@selinc.com>
Content-Type: text/plain; charset=ISO-8859-1
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

Bruce_Leonard@selinc.com wrote:
> Bill Gatliff <bgat@billgatliff.com> wrote on 11/06/2008 10:36:58 AM:
> 
>> Scott Wood wrote:
>>> Bruce_Leonard@selinc.com wrote:
>>>> In the Cafe driver, Linux Device Drivers 3rd Edition, and
>>>> DMA-mapping.txt everyone talks about how to allocate buffers using
>>>> dma/pci_alloc_coherent(), but no one talks about how to actually use
>>>> it. I'm pretty sure (even in my ignorance) that just allocating a DMA
>>>> coherent buffer and then copying in and out of it does NOT actually
>>>> engage the underlying hardware and perform a DMA transfer.
>> Does the "adma" stuff address this any?
>>
> 
> What is "adma"?
> 
> Bruce
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 

Asynchronous DMA.  See this paper, for example:

http://www.power.org/devcon/07/Session_Downloads/PADC07_Aytac_Haluk_09_13_07_layout_FINAL.pdf

It looks like the structure of interest is async_tx_submit.  Beyond
that, I can't offer much because I haven't used it.


b.g.
-- 
Bill Gatliff
bgat@billgatliff.com
