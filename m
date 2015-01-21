Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pa0-x22b.google.com (mail-pa0-x22b.google.com
 [IPv6:2607:f8b0:400e:c03::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 604081A0E29
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jan 2015 05:53:30 +1100 (AEDT)
Received: by mail-pa0-f43.google.com with SMTP id eu11so17310154pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jan 2015 10:53:28 -0800 (PST)
Date: Wed, 21 Jan 2015 10:53:20 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Zidan Wang <zidan.wang@freescale.com>
Subject: Re: [alsa-devel][PATCH 3/3] ASoC: fsl_sai: Add support for Right-J
 mode
Message-ID: <20150121185319.GA4238@Alpha>
References: <1421756480-7055-1-git-send-email-zidan.wang@freescale.com>
 <1421756480-7055-4-git-send-email-zidan.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1421756480-7055-4-git-send-email-zidan.wang@freescale.com>
Cc: alsa-devel@alsa-project.org, timur@tabi.org, Xiubo.Lee@gmail.com,
 tiwai@suse.de, linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
 perex@perex.cz, broonie@kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 20, 2015 at 08:21:20PM +0800, Zidan Wang wrote:
> Add Right-J mode and set TCR5 FBT bit to let data right justify.
> 
> Signed-off-by: Zidan Wang <zidan.wang@freescale.com>

> -	if (sai->is_lsb_first)
> +	if (sai->is_lsb_first && sai->is_right_j_mode)
>  		val_cr5 |= FSL_SAI_CR5_FBT(0);

Are you sure that FBT(0) is correct for right justified mode?
Because the original code is using FBT(0) for the lsb_first
situation and it shouldn't be right justified mode as default.

Nicolin
