Return-Path: <Li.Xiubo@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0144.outbound.protection.outlook.com [207.46.163.144])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 234271A0071
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Aug 2014 18:31:56 +1000 (EST)
From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
To: "shengjiu.wang@freescale.com" <shengjiu.wang@freescale.com>
Subject: RE: [alsa-devel] [PATCH V1 1/3] ASoC: fsl: Kconfig: remove dependence
 of SND_IMX_SOC for SND_SOC_IMX_PCM_DMA
Date: Tue, 19 Aug 2014 08:31:47 +0000
Message-ID: <fb8086a68ed74e0794d34f66c2396b30@BN1PR0301MB0609.namprd03.prod.outlook.com>
References: <cover.1408350626.git.shengjiu.wang@freescale.com>
 <f30ba4e2c4eb6702fa40bd255036e6e9ad6eb47d.1408350626.git.shengjiu.wang@freescale.com>
 <53F22F5E.2090601@metafoo.de> <20140819074103.GA5806@audiosh1>
 <d7b06608abcc4f098789f63cb9f36eef@BN1PR0301MB0609.namprd03.prod.outlook.com>
 <20140819082108.GB5806@audiosh1>
In-Reply-To: <20140819082108.GB5806@audiosh1>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "Fabio.Estevam@freescale.com" <Fabio.Estevam@freescale.com>,
 "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Lars-Peter Clausen <lars@metafoo.de>, "timur@tabi.org" <timur@tabi.org>,
 "arnd@arndb.de" <arnd@arndb.de>, "shc_work@mail.ru" <shc_work@mail.ru>,
 "tiwai@suse.de" <tiwai@suse.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "perex@perex.cz" <perex@perex.cz>,
 "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>, "xobs@kosagi.com" <xobs@kosagi.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > > Lars-Peter Clausen & Arnd
> > >
> > > The purpose of Arnd's patch is same with me, which is to resolve the =
build
> > > error when SND_SOC_IMX_PCM_DMA=3Dm & SND_SOC_FSL_SSI/SAI/ESAI/SPDIF=
=3Dy, the
> > > error is "undefined reference to `imx_pcm_dma_init'".
> > > But Arnd's patch didn't involve this situation that SND_IMX_SOC=3Dn &
> > > SND_SOC_IMX_PCM_DMA=3Dm.
> > >
> > > Currently I think out a solution for this issue is to change
> > >
> > > select SND_SOC_IMX_PCM_DMA if SND_IMX_SOC !=3D n
> > >
> > > to
> > >
> > > depends on SND_SOC_IMX_PCM_DMA !=3D m
> > >
> > > How do you think about this?
> > >
> >
> > What will happen if to build both SAI/ESAI and IMX_PCM_DMA as modules a=
t the
> same
> > time ?
> >
> > Thanks,
> >
> > BRs
> > Xiubo
>=20
> I didn't find error/warning when SAI/ESAI and IMX_PCM_DMA are as modules.=
 The
> build is successful.
>=20

Yes, but if IMX_PCM_DMA =3D=3D m, the SAI/ESAI will be invisible in menucon=
fig....
Does it matter here ?

BRs
Xiubo


> >
> >
> > > best regards
> > > Wang shengjiu
