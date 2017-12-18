Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z0R1y1q7tzDqhB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Dec 2017 14:13:09 +1100 (AEDT)
Subject: Re: [PATCH v4 00/11] ASoC: fsl_ssi: Clean up - coding style level
To: Nicolin Chen <nicoleotsuka@gmail.com>, broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org, lgirdwood@gmail.com, fabio.estevam@nxp.com,
 mail@maciej.szmigiero.name, caleb@crome.org, arnaud.mouiche@invoxia.com,
 lukma@denx.de, kernel@pengutronix.de
References: <1513565530-33957-1-git-send-email-nicoleotsuka@gmail.com>
From: Timur Tabi <timur@tabi.org>
Message-ID: <4e69ef31-3aa6-66ea-331b-8a7472a66a15@tabi.org>
Date: Sun, 17 Dec 2017 21:13:04 -0600
MIME-Version: 1.0
In-Reply-To: <1513565530-33957-1-git-send-email-nicoleotsuka@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/17/17 8:51 PM, Nicolin Chen wrote:
> Nicolin Chen (11):
>    ASoC: fsl_ssi: Rename fsl_ssi_private to fsl_ssi
>    ASoC: fsl_ssi: Cache pdev->dev pointer
>    ASoC: fsl_ssi: Refine all comments
>    ASoC: fsl_ssi: Rename registers and fields macros
>    ASoC: fsl_ssi: Refine indentations and wrappings
>    ASoC: fsl_ssi: Refine printk outputs
>    ASoC: fsl_ssi: Rename cpu_dai parameter to dai
>    ASoC: fsl_ssi: Rename scr_val to scr
>    ASoC: fsl_ssi: Replace fsl_ssi_rxtx_reg_val with fsl_ssi_regvals
>    ASoC: fsl_ssi: Rename i2smode to i2s_net
>    ASoC: fsl_ssi: Define ternary macros to simplify code

Acked-by: Timur Tabi <timur@tabi.org>
