Return-Path: <Li.Xiubo@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0156.outbound.protection.outlook.com [207.46.163.156])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 29E7D2C009C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Dec 2013 14:44:20 +1100 (EST)
From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
To: Mark Brown <broonie@kernel.org>
Subject: RE: [PATCH] ASoC: fsl_sai: Fix one bug for hardware limitation.
Date: Tue, 31 Dec 2013 03:29:04 +0000
Message-ID: <d2c60ec3b8a14500afef632e6163d57e@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1388026642-1464-1-git-send-email-Li.Xiubo@freescale.com>
 <20131230121520.GR31886@sirena.org.uk>
In-Reply-To: <20131230121520.GR31886@sirena.org.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "tiwai@suse.de" <tiwai@suse.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "timur@tabi.org" <timur@tabi.org>, "perex@perex.cz" <perex@perex.cz>,
 "shawn.guo@linaro.org" <shawn.guo@linaro.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Mark,

> Subject: Re: [PATCH] ASoC: fsl_sai: Fix one bug for hardware limitation.
>=20
> On Thu, Dec 26, 2013 at 10:57:22AM +0800, Xiubo Li wrote:
> > This is maybe one bug or a limitation of the hardware that the {T,R}CR2=
's
> > Synchronous Mode bits must be set as late as possible, or the SAI devic=
e
> > maybe hanged up, and there has not any explaination about this limitati=
on
> > in the SAI Data Sheet.
>=20
> If they really should be set as late as possible then I'd expect them to
> be being set in the trigger function, that's what gets called as the
> audio actually starts streaming.  This is moving it to the startup
> function which is one of the first things that happens during audio
> stream setup so presumably makes things worse.
>=20

Yes, it is.

If everything is OK, I will send another new patch later.

Thanks,

---
Best Regards,
Xiubo
