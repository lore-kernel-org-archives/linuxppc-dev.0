Return-Path: <festevam@gmail.com>
Received: from mail-oi0-x241.google.com (mail-oi0-x241.google.com
 [IPv6:2607:f8b0:4003:c06::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v1cXl6PdCzDqV8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jan 2017 00:24:39 +1100 (AEDT)
Received: by mail-oi0-x241.google.com with SMTP id w144so6352158oiw.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Jan 2017 05:24:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170115124331.3546-1-nicolas.iooss_linux@m4x.org>
References: <20170115124331.3546-1-nicolas.iooss_linux@m4x.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 15 Jan 2017 11:24:36 -0200
Message-ID: <CAOMZO5DaR1r2E21njxtvg-4BZc1uR4rE25z0ncqavqZq76sm_Q@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH 1/1] ASoC: fsl_asrc: use
 dma_transfer_direction enum when calling dmaengine_prep_dma_cyclic
To: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
Cc: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jan 15, 2017 at 10:43 AM, Nicolas Iooss
<nicolas.iooss_linux@m4x.org> wrote:
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

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
