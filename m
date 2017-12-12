Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pg0-x235.google.com (mail-pg0-x235.google.com
 [IPv6:2607:f8b0:400e:c05::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yxGMQ3vRQzDrXd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Dec 2017 10:32:33 +1100 (AEDT)
Received: by mail-pg0-x235.google.com with SMTP id y6so416963pgp.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Dec 2017 15:32:33 -0800 (PST)
Date: Tue, 12 Dec 2017 15:32:24 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org, fabio.estevam@nxp.com, timur@tabi.org,
 mail@maciej.szmigiero.name, caleb@crome.org, lgirdwood@gmail.com
Subject: Re: [PATCH 00/10] ASoC: fsl_ssi: Clean up - coding style level
Message-ID: <20171212233223.GA2019@Asurada-Nvidia>
References: <1512420403-10164-1-git-send-email-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1512420403-10164-1-git-send-email-nicoleotsuka@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Dec 04, 2017 at 12:46:33PM -0800, Nicolin Chen wrote:

> Nicolin Chen (10):
>   ASoC: fsl_ssi: Remove unused struct device
>   ASoC: fsl_ssi: Rename fsl_ssi_private to fsl_ssi
>   ASoC: fsl_ssi: Cache pdev->dev pointer
>   ASoC: fsl_ssi: Refine all comments
>   ASoC: fsl_ssi: Rename registers and fields macros
>   ASoC: fsl_ssi: Refine indentations and wrappings
>   ASoC: fsl_ssi: Refine printk outputs
>   ASoC: fsl_ssi: Rename cpu_dai parameter to dai
>   ASoC: fsl_ssi: Rename scr_val to scr
>   ASoC: fsl_ssi: Replace fsl_ssi_rxtx_reg_val with fsl_ssi_regvals

Have revised some comments at one of patches and rebased the rest.
Will send v2 tonight. So let's ignore this version for now. Thanks
