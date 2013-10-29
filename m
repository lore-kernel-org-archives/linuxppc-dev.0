Return-Path: <B47053@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C7B2C2C0127
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2013 15:01:06 +1100 (EST)
From: Xiubo Li-B47053 <B47053@freescale.com>
To: Mark Brown <broonie@kernel.org>
Subject: RE: [PATCHv1 1/8] ALSA: Add SAI SoC Digital Audio Interface driver.
Date: Tue, 29 Oct 2013 04:00:57 +0000
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F8286BDB5@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
 <1382000477-17304-2-git-send-email-Li.Xiubo@freescale.com>
 <20131024110543.GA18506@sirena.org.uk>
In-Reply-To: <20131024110543.GA18506@sirena.org.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "tiwai@suse.de" <tiwai@suse.de>, Wang Huan-B18965 <B18965@freescale.com>,
 "timur@tabi.org" <timur@tabi.org>, "perex@perex.cz" <perex@perex.cz>,
 Guo Shawn-R65073 <r65073@freescale.com>,
 "LW@KARO-electronics.de" <LW@KARO-electronics.de>,
 "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
 Chen Guangyu-B42378 <B42378@freescale.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "grant.likely@linaro.org" <grant.likely@linaro.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "ian.campbell@citrix.com" <ian.campbell@citrix.com>,
 "pawel.moll@arm.com" <pawel.moll@arm.com>,
 "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 "oskar@scara.com" <oskar@scara.com>,
 Estevam Fabio-R49496 <r49496@freescale.com>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "rob@landley.net" <rob@landley.net>,
 Jin Zhengxiong-R64188 <R64188@freescale.com>,
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


> > +static struct snd_pcm_hardware snd_fsl_hardware =3D {
> > +	.info =3D SNDRV_PCM_INFO_INTERLEAVED |
> > +		SNDRV_PCM_INFO_BLOCK_TRANSFER |
> > +		SNDRV_PCM_INFO_MMAP |
> > +		SNDRV_PCM_INFO_MMAP_VALID |
> > +		SNDRV_PCM_INFO_PAUSE |
> > +		SNDRV_PCM_INFO_RESUME,
> > +	.formats =3D SNDRV_PCM_FMTBIT_S16_LE,
> > +	.rate_min =3D 8000,
> > +	.channels_min =3D 2,
> > +	.channels_max =3D 2,
> > +	.buffer_bytes_max =3D FSL_SAI_DMABUF_SIZE,
> > +	.period_bytes_min =3D 4096,
> > +	.period_bytes_max =3D FSL_SAI_DMABUF_SIZE / TCD_NUMBER,
> > +	.periods_min =3D TCD_NUMBER,
> > +	.periods_max =3D TCD_NUMBER,
> > +	.fifo_size =3D 0,
> > +};
>=20
> There's a patch in -next that lets the generic dmaengine code figure out
> some settings from the dmacontroller rather than requiring the driver to
> explicitly provide configuration - it's "ASoC: dmaengine-pcm: Provide
> default config".  Please update your driver to use this, or let's work
> out what it doesn't do any try to fix it.
>=20

I couldn't find the patch in the next and other trees.
Does this patch has been submitted to the -next tree ?
Or could you tell me how to find the patch please?

Thanks very much.
