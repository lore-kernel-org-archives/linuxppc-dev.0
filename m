Return-Path: <caleb@crome.org>
Received: from mail-ig0-x230.google.com (mail-ig0-x230.google.com
 [IPv6:2607:f8b0:4001:c05::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9827F1A0CC2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jan 2016 06:25:55 +1100 (AEDT)
Received: by mail-ig0-x230.google.com with SMTP id z14so62119013igp.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jan 2016 11:25:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <201601190245.2gbScBue%fengguang.wu@intel.com>
References: <1453142205-83135-1-git-send-email-caleb@crome.org>
 <201601190245.2gbScBue%fengguang.wu@intel.com>
From: Caleb Crome <caleb@crome.org>
Date: Mon, 18 Jan 2016 11:25:32 -0800
Message-ID: <CAG5mAdyz4zsJugj4LcG+a_g=QmTZsvXvk9Bm+k0SwxpZbYsGZQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_ssi: Set watermark and maxburst settings to
 eliminate DMA xruns on imx processors
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, Timur Tabi <timur@tabi.org>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 18, 2016 at 10:59 AM, kbuild test robot <lkp@intel.com> wrote:
> Hi Caleb,
>
> [auto build test ERROR on asoc/for-next]
> [also build test ERROR on v4.4 next-20160118]
> [if your patch is applied to the wrong git tree, please drop us a note to help improving the system]
>
> url:    https://github.com/0day-ci/linux/commits/Caleb-Crome/ASoC-fsl_ssi-Set-watermark-and-maxburst-settings-to-eliminate-DMA-xruns-on-imx-processors/20160119-024143
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
> config: x86_64-randconfig-x019-01180513 (attached as .config)
> reproduce:


Doh, sorry sent the wrong patch file.  Will re-submit shortly.

-Caleb
