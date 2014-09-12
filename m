Return-Path: <shengjiu.wang@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0102.outbound.protection.outlook.com [65.55.169.102])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A46971A000C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Sep 2014 15:12:07 +1000 (EST)
Date: Fri, 12 Sep 2014 13:11:42 +0800
From: Shengjiu Wang <shengjiu.wang@freescale.com>
To: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH V2] ASoC: fsl_ssi: refine ipg clock usage in this module
Message-ID: <20140912051140.GA3644@audiosh1>
References: <27584da8e3ab291ab8dbcbb411579613f8384a59.1410413734.git.shengjiu.wang@freescale.com>
 <54125DEF.4090101@tabi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <54125DEF.4090101@tabi.org>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, Li.Xiubo@freescale.com,
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

On Thu, Sep 11, 2014 at 09:43:59PM -0500, Timur Tabi wrote:
> Shengjiu Wang wrote:
> >+	ret = clk_prepare_enable(ssi_private->clk);
> >+	if (ret)
> >+		return ret;
> 
> Will this work on PowerPC, where ssi_private->clk is always NULL?

When ssi_private->clk is NULL, then ret = 0, so here will not return,
the code in below will be continuously executed.
I think it work on PowerPC.

wang shengjiu
