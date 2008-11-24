Return-Path: <Bruce_Leonard@selinc.com>
Received: from tesla.selinc.com (tesla.selinc.com [12.110.71.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "tesla.selinc.com", Issuer "RSA Data Security,
	Inc." (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 108ADDDE22
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Nov 2008 08:36:17 +1100 (EST)
In-Reply-To: <492B1C74.9070700@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: Async DMA question regarding dma_async_memcpy_buf_to_buf
MIME-Version: 1.0
Message-ID: <OF02253237.E6F76439-ON8825750B.00763582-8825750B.00768F99@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Mon, 24 Nov 2008 13:35:10 -0800
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Scott Wood <scottwood@freescale.com> wrote on 11/24/2008 01:28:20 PM:

> Bruce_Leonard@selinc.com wrote:
> > Maybe (with you clarification) this is starting to make sense.  It 
doesn't 
> > matter if the "src" is host memory or PCI space.  What the "src" and 
it's 
> > DMA_TO_DEVICE mapping is saying to the kernel is "this data needs to 
be 
> > moved into the DMA engine", while the "dest" and it's DMA_FROM_DEIVCE 
> > mapping is telling the kernel "this data needs to be moved from the 
DMA 
> > engine".
> 
> Right.
> 
> -Scott

Thank you sooooo much.  Now it makes sense.  I guess I was getting bogged 
down in the hardware sense of "src" and "dest"

Thanks again.

Bruce
