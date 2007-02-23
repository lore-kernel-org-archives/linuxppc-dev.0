Return-Path: <bzolnier@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.187])
	by ozlabs.org (Postfix) with ESMTP id AE1E4DDDCA
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Feb 2007 10:36:49 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id m18so178580nfc
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Feb 2007 15:36:48 -0800 (PST)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] (pata-2.6 fix queue) sl82c105: DMA support code cleanup
	(take 3)
Date: Sat, 24 Feb 2007 00:42:59 +0100
References: <200702140043.25244.sshtylyov@ru.mvista.com>
	<200702231913.55522.sshtylyov@ru.mvista.com>
In-Reply-To: <200702231913.55522.sshtylyov@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702240042.59737.bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Friday 23 February 2007, Sergei Shtylyov wrote:
> Fold the now equivalent code in the ide_dma_check() method into a mere call to
> ide_use_dma().  Make config_for_dma() return non-zero if DMA mode has been set
> and call it from the ide_dma_check() method instead of ide_dma_on().
> Also, defer writing the DMA timings to the chip registers until DMA is actually
> turned on (and do not enable IORDY for DMA).  Remove unnecessary code from the
> init_hwif() method, improve its looks overall, and also rename the driver's
> ide_dma_check() and dma_start() methods.
> 
> ---
> This version takes into account that the ide-use-fast-pio.patch had been merged
> to mainline...

applied
