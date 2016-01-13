Return-Path: <LW@KARO-electronics.de>
Received: from mail.karo-electronics.de (mail.karo-electronics.de
 [81.173.242.67]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 391991A06CD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2016 22:11:58 +1100 (AEDT)
Date: Wed, 13 Jan 2016 12:11:35 +0100
From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
To: Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Fabio Estevam
 <fabio.estevam@freescale.com>, Jaroslav Kysela <perex@perex.cz>, Liam
 Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Takashi Iwai <tiwai@suse.com>, Timur Tabi <timur@tabi.org>, Xiubo Li
 <Xiubo.Lee@gmail.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] ASoC: fsl: imx-sgtl5000: make audmux optional for
 imx sound driver
Message-ID: <20160113121135.5c18f4ee@ipc1.ka-ro>
In-Reply-To: <20160112182253.GD6588@sirena.org.uk>
References: <1452622411-16674-1-git-send-email-LW@KARO-electronics.de>
 <1452622411-16674-2-git-send-email-LW@KARO-electronics.de>
 <20160112182253.GD6588@sirena.org.uk>
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

> On Tue, Jan 12, 2016 at 07:13:30PM +0100, Lothar Wa=C3=9Fmann wrote:
>=20
> > i.MX6UL does not have the audio multiplexer (AUDMUX) like e.g. i.MX6Q,
> > but apart from that can use the same audio driver. Make audmux
> > optional for the imx-sgtl5000 driver, so it can be used on i.MX6UL
> > too. Also i.MX6UL requires use of the SAI interface rather than SSI.
>=20
> If it doesn't have the audmux can you use simple-card?
>
I'll have a look at it. Thanks for the hint.


Lothar Wa=C3=9Fmann
