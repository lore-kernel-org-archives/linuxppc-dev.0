Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tpf1M0f0XzDq8f
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Dec 2016 03:52:54 +1100 (AEDT)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Timur Tabi <timur@tabi.org>
Cc: "Harisangam\, Sharvari \(S.\)" <sharvari.harisangam@visteon.com>,
 "alsa-devel\@alsa-project.org" <alsa-devel@alsa-project.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Takashi Iwai <tiwai@suse.de>,
 "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] ASoC : fsl_ssi : Correct the condition to check AC97 mode
References: <20161228110636.GA14768@ubuntu> <87inq4f6pa.fsf@linux-m68k.org>
 <9ebb798c-6040-9262-9625-ddcebd05a188__32955.7460187518$1482940206$gmane$org@tabi.org>
Date: Wed, 28 Dec 2016 17:52:43 +0100
In-Reply-To: <9ebb798c-6040-9262-9625-ddcebd05a188__32955.7460187518$1482940206$gmane$org@tabi.org>
 (Timur Tabi's message of "Wed, 28 Dec 2016 09:48:42 -0600")
Message-ID: <87eg0sf12c.fsf@linux-m68k.org>
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

On Dez 28 2016, Timur Tabi <timur@tabi.org> wrote:

> Andreas Schwab wrote:
>>> > +	return !!(ssi_private->dai_fmt & SND_SOC_DAIFMT_AC97) ==
>>> > +		SND_SOC_DAIFMT_AC97;
>> This is never true.
>
> I think the right parenthesis should be at the end of the expression.

That would still test the wrong bitfield.

And all that is obsolete anyway since commit 5b64c173cd (of Sep 2015).

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
