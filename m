Return-Path: <guangyu.chen@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0188.outbound.protection.outlook.com [207.46.163.188])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EBFE81A0072
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Aug 2014 16:53:03 +1000 (EST)
Date: Fri, 8 Aug 2014 14:42:43 +0800
From: Nicolin Chen <Guangyu.Chen@freescale.com>
To: Shengjiu Wang <shengjiu.wang@freescale.com>
Subject: Re: [alsa-devel] [PATCH V4 0/2]  refine esai for tdm support
Message-ID: <20140808064243.GA6333@MrMyself>
References: <cover.1407480333.git.shengjiu.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <cover.1407480333.git.shengjiu.wang@freescale.com>
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org, timur@tabi.org,
 arnd@arndb.de, shc_work@mail.ru, tiwai@suse.de, Li.Xiubo@freescale.com,
 lgirdwood@gmail.com, perex@perex.cz, nicoleotsuka@gmail.com,
 broonie@kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 08, 2014 at 02:47:20PM +0800, Shengjiu Wang wrote:
> These patchs is to refine esai for tdm support.
> 
> Changes for V4
> - update the comments for patch 2
> 
> Changes for V3
> - update the comments for patch 2
> 
> Changes for V2
> - update the comments according the reviewer's suggestion
> - add init value for slots and change pin to pins.
> 
> 
> Shengjiu Wang (2):
>   ASoC: fsl_esai: refine esai for TDM support
>   Revert "ASoC: fsl-esai: Add .xlate_tdm_slot_mask() support."
> 
>  sound/soc/fsl/Kconfig    |    1 -
>  sound/soc/fsl/fsl_esai.c |   16 +++++++++++-----
>  sound/soc/fsl/fsl_esai.h |    8 ++++----
>  3 files changed, 15 insertions(+), 10 deletions(-)

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thank you

> 
> -- 
> 1.7.9.5
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
