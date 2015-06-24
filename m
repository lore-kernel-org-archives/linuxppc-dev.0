Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 705611A0601
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2015 22:40:22 +1000 (AEST)
Message-ID: <558AA3CD.3070802@tabi.org>
Date: Wed, 24 Jun 2015 07:34:21 -0500
From: Timur Tabi <timur@tabi.org>
MIME-Version: 1.0
To: Nicolin Chen <nicoleotsuka@gmail.com>,
 Shengjiu Wang <shengjiu.wang@freescale.com>
CC: Xiubo.Lee@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] ASoC: fsl: Add dedicated DMA buffer size for each cpu dai
References: <1435055033-12608-1-git-send-email-shengjiu.wang@freescale.com>
 <20150624070037.GA2926@Asurada-CZ80>
In-Reply-To: <20150624070037.GA2926@Asurada-CZ80>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicolin Chen wrote:
>> >As the ssi is not the only cpu dai, there are esai, spdif, sai.
>> >and imx_pcm_dma can be used by all of them. Especially ESAI need
>> >a larger DMA buffer size. So Add dedicated DMA buffer for each cpu
>> >dai.
>> >
>> >Signed-off-by: Shengjiu Wang<shengjiu.wang@freescale.com>
> Acked-by: Nicolin Chen<nicoleotsuka@gmail.com>

Acked-by: Timur Tabi <timur@tabi.org>
