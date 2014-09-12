Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1E0531A006C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Sep 2014 12:44:05 +1000 (EST)
Message-ID: <54125DEF.4090101@tabi.org>
Date: Thu, 11 Sep 2014 21:43:59 -0500
From: Timur Tabi <timur@tabi.org>
MIME-Version: 1.0
To: Shengjiu Wang <shengjiu.wang@freescale.com>, nicoleotsuka@gmail.com,
 Li.Xiubo@freescale.com, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.de
Subject: Re: [PATCH V2] ASoC: fsl_ssi: refine ipg clock usage in this module
References: <27584da8e3ab291ab8dbcbb411579613f8384a59.1410413734.git.shengjiu.wang@freescale.com>
In-Reply-To: <27584da8e3ab291ab8dbcbb411579613f8384a59.1410413734.git.shengjiu.wang@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Shengjiu Wang wrote:
> +	ret = clk_prepare_enable(ssi_private->clk);
> +	if (ret)
> +		return ret;

Will this work on PowerPC, where ssi_private->clk is always NULL?
