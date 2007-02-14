Return-Path: <bzolnier@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.170])
	by ozlabs.org (Postfix) with ESMTP id A8D32DDE2D
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 06:42:51 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so280408ugf
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 11:42:49 -0800 (PST)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] (pata-2.6 fix queue) sl82c105: DMA support code cleanup
Date: Wed, 14 Feb 2007 20:48:32 +0100
References: <200702140043.25244.sshtylyov@ru.mvista.com>
In-Reply-To: <200702140043.25244.sshtylyov@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702142048.32535.bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tuesday 13 February 2007 22:43, Sergei Shtylyov wrote:
> Fold the now equivalent code in the ide_dma_check() method into a mere call to
> ide_use_dma().  Make config_for_dma() return non-zero if DMA mode has been set
> and call it from the ide_dma_check() method instead of ide_dma_on().
> Also, defer writing the DMA timings to the chip registers until DMA is actually
> turned on (and do not enable IORDY for DMA).  Remove unnecessary code from the
> init_hwif() method, improve its looks overall, and also rename the driver's
> ide_dma_check() and dma_start() methods.
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> ---
> The patch has been actually tested at last. :-)
> Note that now this driver can be joined to the ide-use-fast-pio patch.

applied
