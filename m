Return-Path: <LW@KARO-electronics.de>
Received: from mail.karo-electronics.de (mail.karo-electronics.de
 [81.173.242.67]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 97F731A0754
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2016 23:38:32 +1100 (AEDT)
Date: Wed, 13 Jan 2016 13:38:10 +0100
From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
To: Timur Tabi <timur@tabi.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Fabio Estevam
 <fabio.estevam@freescale.com>, Jaroslav Kysela <perex@perex.cz>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Nicolin
 Chen <nicoleotsuka@gmail.com>, Takashi Iwai <tiwai@suse.com>, Xiubo Li
 <Xiubo.Lee@gmail.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] ASoC: fsl: select SND_SOC_FSL_SAI or
 SND_SOC_FSL_SSI depending on SoC type
Message-ID: <20160113133810.167d2dbb@ipc1.ka-ro>
In-Reply-To: <569545EB.4080307@tabi.org>
References: <1452622411-16674-1-git-send-email-LW@KARO-electronics.de>
 <1452622411-16674-2-git-send-email-LW@KARO-electronics.de>
 <1452622411-16674-3-git-send-email-LW@KARO-electronics.de>
 <569545EB.4080307@tabi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

> Lothar Wa=C3=9Fmann wrote:
> > -	select SND_SOC_FSL_SSI
> > +	select SND_SOC_FSL_SAI if SOC_IMX6UL
> > +	select SND_SOC_FSL_SSI if SOC_IMX6Q || SOC_IMX6SL || SOC_IMX6SX
>=20
> I don't think this is compatible with a multiarch kernel.
>
Why? If more than one of the IMX6 SoCs are selected, both interfaces
may be selected at the same time without any harm.


Lothar Wa=C3=9Fmann
