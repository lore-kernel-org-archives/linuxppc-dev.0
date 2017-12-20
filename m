Return-Path: <srs0=zbx3=dq=kernel.crashing.org=benh@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1ddQ6WYrzDrkB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 13:14:50 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3z1ddQ5Lrxz8tCT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 13:14:50 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3z1ddQ0FwSz9s7v
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Dec 2017 13:14:49 +1100 (AEDT)
Message-ID: <1513736065.2743.16.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Add aacraid and nvme to powernv_defconfig
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev
 <linuxppc-dev@ozlabs.org>
Date: Wed, 20 Dec 2017 13:14:25 +1100
In-Reply-To: <ed9aaffc-bb59-a39a-7ddc-55d664a93d8c@ozlabs.ru>
References: <1513734660.2743.14.camel@kernel.crashing.org>
 <ed9aaffc-bb59-a39a-7ddc-55d664a93d8c@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-12-20 at 12:59 +1100, Alexey Kardashevskiy wrote:
> On 20/12/17 12:51, Benjamin Herrenschmidt wrote:
> > These adapters can be found in a number of our systems, so let's
> > enable the corresponding drivers by default.
> > 
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > ---
> > --- a/arch/powerpc/configs/powernv_defconfig	2017-12-19 18:37:24.803470591 -0600
> > +++ b/arch/powerpc/configs/powernv_defconfig	2017-12-19 19:47:57.931952417 -0600
> > @@ -97,6 +97,7 @@
> >  CONFIG_BLK_DEV_RAM=y
> >  CONFIG_BLK_DEV_RAM_SIZE=65536
> >  CONFIG_VIRTIO_BLK=m
> > +CONFIG_BLK_DEV_NVME=y
> >  CONFIG_IDE=y
> >  CONFIG_BLK_DEV_IDECD=y
> >  CONFIG_BLK_DEV_GENERIC=y
> > @@ -113,6 +114,7 @@
> >  CONFIG_SCSI_CXGB4_ISCSI=m
> >  CONFIG_SCSI_BNX2_ISCSI=m
> >  CONFIG_BE2ISCSI=m
> > +CONFIG_SCSI_AACRAID=y
> >  CONFIG_SCSI_MPT2SAS=m
> >  CONFIG_SCSI_SYM53C8XX_2=m
> >  CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=0
> > 
> 
> "y", not "m"?

Yes. I like my boot devices to be "y"

Cheers,
Ben.
