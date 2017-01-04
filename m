Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.188])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ttqgw4V4XzDqHW
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jan 2017 23:22:19 +1100 (AEDT)
From: David Laight <David.Laight@ACULAB.COM>
To: "'Harisangam, Sharvari (S.)'" <sharvari.harisangam@visteon.com>, "Timur
 Tabi" <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li
 <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.de>
CC: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH]  ASoC : fsl_ssi : Correct the condition to check AC97 mode
Date: Wed, 4 Jan 2017 12:22:09 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DB025783A@AcuExch.aculab.com>
References: <20161228110636.GA14768@ubuntu>
In-Reply-To: <20161228110636.GA14768@ubuntu>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Harisangam, Sharvari (S.)
> Sent: 28 December 2016 11:07
>  Corrected the condition to check if ssi is configured for AC97
>  mode. Other modes like dsp_a also satisfy the ANDing condition.

Under the assumption that the constants have 1 bit set nothing is wrong.

	David

...
> -	return !!(ssi_private->dai_fmt & SND_SOC_DAIFMT_AC97);
...
> -	if (fmt & SND_SOC_DAIFMT_AC97)
...
