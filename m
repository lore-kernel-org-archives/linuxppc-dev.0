Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v1mMF4J3NzDqVQ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jan 2017 06:16:57 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id y143so12730709pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Jan 2017 11:16:57 -0800 (PST)
Date: Sun, 15 Jan 2017 11:16:50 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
Cc: Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] ASoC: fsl_asrc: use dma_transfer_direction enum when
 calling dmaengine_prep_dma_cyclic
Message-ID: <20170115191649.GA4465@Asurada-CZ80>
References: <20170115124331.3546-1-nicolas.iooss_linux@m4x.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170115124331.3546-1-nicolas.iooss_linux@m4x.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jan 15, 2017 at 01:43:31PM +0100, Nicolas Iooss wrote:
> When fsl_asrc_dma_prepare_and_submit() calls
> dmaengine_prep_dma_cyclic(), it uses either DMA_TO_DEVICE or
> DMA_FROM_DEVICE. These values are both items of dma_data_direction enum,
> not of dma_data_direction enum, which is the type expected by
> dmaengine_prep_dma_cyclic().
> 
> Replace DMA_TO_DEVICE with DMA_MEM_TO_DEV and DMA_FROM_DEVICE with
> DMA_DEV_TO_MEM to fix this type mismatch issue.
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss_linux@m4x.org>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thanks.
