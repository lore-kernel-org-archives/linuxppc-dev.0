Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xC2NB1PPFzDrK8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 13:20:26 +1000 (AEST)
Subject: Re: [PATCH] sound: fsl_dma: remove dma_object path member
To: Rob Herring <robh@kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Fabio Estevam <fabio.estevam@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org
References: <20170718214339.7774-59-robh@kernel.org>
From: Timur Tabi <timur@tabi.org>
Message-ID: <2f0aec70-6f29-9472-4137-fe7257186a12@tabi.org>
Date: Tue, 18 Jul 2017 22:12:17 -0500
MIME-Version: 1.0
In-Reply-To: <20170718214339.7774-59-robh@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 7/18/17 4:43 PM, Rob Herring wrote:
> -		dev_err(&pdev->dev, "could not determine resources for %s\n",
> -			ssi_np->full_name);
> +		dev_err(&pdev->dev, "could not determine resources for %pOF\n",
> +			ssi_np);

I think you meant to include this in the other patch.
