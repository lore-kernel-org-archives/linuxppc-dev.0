Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A4EFA1A024B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 May 2015 01:27:41 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 0/3] Add SDHCI support for APM X-Gene SoC using ARASAN
 SDHCI controller.
Date: Mon, 04 May 2015 17:27:11 +0200
Message-ID: <8897362.mqzfqi11lX@wuerfel>
In-Reply-To: <1430746792-32574-1-git-send-email-stripathi@apm.com>
References: <1430746792-32574-1-git-send-email-stripathi@apm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: devicetree@vger.kernel.org, mlangsdo@redhat.com,
 Suman Tripathi <stripathi@apm.com>, jcm@redhat.com, anton@enomsg.org,
 linux-mmc@vger.kernel.org, chris@printf.net, michal.simek@xilinx.com,
 patches@apm.com, ddutile@redhat.com, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday 04 May 2015 19:09:49 Suman Tripathi wrote:
> This patch adds the SDHCI support for APM X-Gene SoC using ARASAN SDHCI controller.
> 
> v1 change:
>  * Use the CONFIG_ARM64_DMA_HAS_IOMMU for dma-mapping.
> 
> v2 change:
>  * Drop the IOMMU support and switching to PIO mode for arasan.
>    controller integrated inside APM X-Gene SoC.
> 
> v3 change:
>  * Change the sdhci-of-arasan.c to support arasan4.9a.
>  * Add quirks for arasan4.9a.
> 
> v4 change:
>  * Cleanup the Documentation and dts.
> 

All three patches

Acked-by: Arnd Bergmann <arnd@arndb.de>
