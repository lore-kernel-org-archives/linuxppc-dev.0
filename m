Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tpcbS1h2mzDq8M
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Dec 2016 02:48:51 +1100 (AEDT)
Subject: Re: [PATCH] ASoC : fsl_ssi : Correct the condition to check AC97 mode
To: Andreas Schwab <schwab@linux-m68k.org>,
 "Harisangam, Sharvari (S.)" <sharvari.harisangam@visteon.com>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20161228110636.GA14768@ubuntu> <87inq4f6pa.fsf@linux-m68k.org>
From: Timur Tabi <timur@tabi.org>
Message-ID: <9ebb798c-6040-9262-9625-ddcebd05a188@tabi.org>
Date: Wed, 28 Dec 2016 09:48:42 -0600
MIME-Version: 1.0
In-Reply-To: <87inq4f6pa.fsf@linux-m68k.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Andreas Schwab wrote:
>> > +	return !!(ssi_private->dai_fmt & SND_SOC_DAIFMT_AC97) ==
>> > +		SND_SOC_DAIFMT_AC97;
> This is never true.

I think the right parenthesis should be at the end of the expression.
