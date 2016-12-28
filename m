Return-Path: <sharvari.harisangam@visteon.com>
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0135.outbound.protection.outlook.com [104.47.0.135])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tpchz6LHtzDq62
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Dec 2016 02:53:39 +1100 (AEDT)
From: "Harisangam, Sharvari (S.)" <sharvari.harisangam@visteon.com>
To: Andreas Schwab <schwab@linux-m68k.org>
CC: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, "Xiubo
 Li" <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]  ASoC : fsl_ssi : Correct the condition to check AC97 mode
Date: Wed, 28 Dec 2016 15:53:33 +0000
Message-ID: <20161228155321.GA19963@ubuntu>
References: <20161228110636.GA14768@ubuntu> <87inq4f6pa.fsf@linux-m68k.org>
In-Reply-To: <87inq4f6pa.fsf@linux-m68k.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 28, 2016 at 03:50:57PM +0100, Andreas Schwab wrote:
> On Dez 28 2016, "Harisangam, Sharvari (S.)" <sharvari.harisangam@visteon.=
com> wrote:
>=20
> > +	return !!(ssi_private->dai_fmt & SND_SOC_DAIFMT_AC97) =3D=3D
> > +		SND_SOC_DAIFMT_AC97;
>=20
> This is never true.
>=20
> Andreas.
>=20
> --=20
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED=
5
> "And now for something completely different."

Ok. I missed the braces there. I will modify and resubmit the patch

-Thanks
Sharvari=
