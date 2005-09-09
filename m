Return-Path: <pantelis.antoniou@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.204])
	by ozlabs.org (Postfix) with ESMTP id 73C9A6823B
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 10 Sep 2005 05:58:46 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id i8so1275996wra
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 09 Sep 2005 12:58:45 -0700 (PDT)
From: Pantelis Antoniou <pantelis.antoniou@gmail.com>
To: linuxppc-embedded@ozlabs.org
Date: Fri, 9 Sep 2005 22:59:37 +0300
References: <19EE6EC66973A5408FBE4CB7772F6F0A02FA20CD@ltnmail.xyplex.com>
In-Reply-To: <19EE6EC66973A5408FBE4CB7772F6F0A02FA20CD@ltnmail.xyplex.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200509092259.37723.pantelis.antoniou@gmail.com>
Subject: Re: [PATCH] cpm_uart: Made non-console uart work
Reply-To: pantelis.antoniou@gmail.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Friday 09 September 2005 22:21, Murch, Christopher wrote:
> We've recently applied the 2.6.13 patch.  We're running on an embedded
> platform using 3 of the cpm uart ports on an 8xx cpu.  After applying the
> 2.6.13 patch the non-console uarts no longer work.  Upon investigation, we
> have found that cpu2cpm_addr() is giving us invalid results for memory
> addresses derived from dma_alloc_coherent().  This causes the cpm to hang.
> We believe that the better approach would be to use the dma address
> supplied by the call to dma_alloc_coherent() instead of trying to convert
> using bus_to_virt() and virt_to_bus().  We believe this is the approach
> taken by other drivers in the 2.6 kernel.  Any comments?
> Thanks for your help.
>

Yes, it would be proper. This is a temporary hack.

What is the IMAP_ADDR value?

And where is the consistent pool located at your board?

> -Chris
> cmurch@mrv.com

Regards

Pantelis
