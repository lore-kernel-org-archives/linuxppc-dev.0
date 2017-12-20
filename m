Return-Path: <srs0=i2it=dq=ozlabs.ru=aik@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1dHg2wTZzDrkB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 12:59:27 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3z1dHg24q8z8shH
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 12:59:27 +1100 (AEDT)
Received: from mail-pl0-x242.google.com (mail-pl0-x242.google.com
 [IPv6:2607:f8b0:400e:c01::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3z1dHf5jHYz9sBW
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Dec 2017 12:59:25 +1100 (AEDT)
Received: by mail-pl0-x242.google.com with SMTP id bd8so8126347plb.9
 for <linuxppc-dev@ozlabs.org>; Tue, 19 Dec 2017 17:59:25 -0800 (PST)
Subject: Re: [PATCH] powerpc: Add aacraid and nvme to powernv_defconfig
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
References: <1513734660.2743.14.camel@kernel.crashing.org>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <ed9aaffc-bb59-a39a-7ddc-55d664a93d8c@ozlabs.ru>
Date: Wed, 20 Dec 2017 12:59:19 +1100
MIME-Version: 1.0
In-Reply-To: <1513734660.2743.14.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 20/12/17 12:51, Benjamin Herrenschmidt wrote:
> These adapters can be found in a number of our systems, so let's
> enable the corresponding drivers by default.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> --- a/arch/powerpc/configs/powernv_defconfig	2017-12-19 18:37:24.803470591 -0600
> +++ b/arch/powerpc/configs/powernv_defconfig	2017-12-19 19:47:57.931952417 -0600
> @@ -97,6 +97,7 @@
>  CONFIG_BLK_DEV_RAM=y
>  CONFIG_BLK_DEV_RAM_SIZE=65536
>  CONFIG_VIRTIO_BLK=m
> +CONFIG_BLK_DEV_NVME=y
>  CONFIG_IDE=y
>  CONFIG_BLK_DEV_IDECD=y
>  CONFIG_BLK_DEV_GENERIC=y
> @@ -113,6 +114,7 @@
>  CONFIG_SCSI_CXGB4_ISCSI=m
>  CONFIG_SCSI_BNX2_ISCSI=m
>  CONFIG_BE2ISCSI=m
> +CONFIG_SCSI_AACRAID=y
>  CONFIG_SCSI_MPT2SAS=m
>  CONFIG_SCSI_SYM53C8XX_2=m
>  CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=0
> 

"y", not "m"?


-- 
Alexey
