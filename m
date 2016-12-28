Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tpbRN1KqCzDq8G
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Dec 2016 01:56:47 +1100 (AEDT)
From: Andreas Schwab <schwab@linux-m68k.org>
To: "Harisangam\, Sharvari \(S.\)" <sharvari.harisangam@visteon.com>
Cc: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 "Xiubo Li" <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.de>,
 "alsa-devel\@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC : fsl_ssi : Correct the condition to check AC97 mode
References: <20161228110636.GA14768@ubuntu>
Date: Wed, 28 Dec 2016 15:50:57 +0100
In-Reply-To: <20161228110636.GA14768@ubuntu> (Sharvari Harisangam's message of
 "Wed, 28 Dec 2016 11:06:44 +0000")
Message-ID: <87inq4f6pa.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Dez 28 2016, "Harisangam, Sharvari (S.)" <sharvari.harisangam@visteon.com> wrote:

> +	return !!(ssi_private->dai_fmt & SND_SOC_DAIFMT_AC97) ==
> +		SND_SOC_DAIFMT_AC97;

This is never true.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
