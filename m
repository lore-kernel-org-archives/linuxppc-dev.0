Return-Path: <SRS0=P3hO=RE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584C7C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 13:03:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA4472084F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 13:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="uLqc/4Gw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA4472084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 449qNc2ntCzDq8Y
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Mar 2019 00:03:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=sirena.org.uk
 (client-ip=2a01:7e01::f03c:91ff:fed4:a3b6; helo=heliosphere.sirena.org.uk;
 envelope-from=broonie@sirena.org.uk; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="uLqc/4Gw"; dkim-atps=neutral
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 449pqc6vVhzDqRy
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Mar 2019 23:38:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jtop4A5EpcUG0rKMeIx3l6MeGsKoOVM1tNtfLoLZ1SM=; b=uLqc/4Gw/aLXDKrAibAZe31ad
 t+KoCXzu8AW2d+cgcGAH8wOVCKSNWgxPv4YRXDDoebyZ3u/S488uCX7Hyzg0l/Vvz0kyukeakLSPd
 7GrHy8WmxiQ9ffN9Px1+rVPH724dHC0O9EIM7psYRx+fUuJUcyRoBcBhTGV3567LP/mRQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gzhQc-0002B4-H8; Fri, 01 Mar 2019 12:38:14 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id ED9C91128742; Fri,  1 Mar 2019 12:38:08 +0000 (GMT)
Date: Fri, 1 Mar 2019 12:38:08 +0000
From: Mark Brown <broonie@kernel.org>
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_asrc: add protection for the asrc of older
 version
Message-ID: <20190301123808.GD7429@sirena.org.uk>
References: <1551407560-29950-1-git-send-email-shengjiu.wang@nxp.com>
 <20190301025356.GA1371@Asurada-Nvidia.nvidia.com>
 <VI1PR0402MB339254C31997242633511D12E3760@VI1PR0402MB3392.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GpGaEY17fSl8rd50"
Content-Disposition: inline
In-Reply-To: <VI1PR0402MB339254C31997242633511D12E3760@VI1PR0402MB3392.eurprd04.prod.outlook.com>
X-Cookie: Yow!
User-Agent: Mutt/1.10.1 (2018-07-13)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "timur@kernel.org" <timur@kernel.org>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--GpGaEY17fSl8rd50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 01, 2019 at 06:55:25AM +0000, S.j. Wang wrote:

> > Alternatively, I feel instead of error-out at here, should we add a HW
> > constraint or at least fence it off at the beginning of the hw_params()=
? This
> > is actually nothing specific to the pair-request function but a hardware
> > constraint.

> How about add constraint in startup?
> static int fsl_asrc_dai_startup(struct snd_pcm_substream *substream,
>                                struct snd_soc_dai *dai)
> {
>        struct fsl_asrc *asrc_priv =3D snd_soc_dai_get_drvdata(dai);
>=20
>        if (asrc_priv->channel_bits =3D=3D 3) {
>                snd_pcm_hw_constraint_step(substream->runtime, 0,
>                                           SNDRV_PCM_HW_PARAM_CHANNELS, 2);
>        }
>=20
>        return 0;
> }

Yes, that's definitely good - the general idea is that we should never
need to return an error from hw_params() as the constraints code will
have filtered out any invalid configurations before they get that far.

--GpGaEY17fSl8rd50
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlx5J7AACgkQJNaLcl1U
h9DsGQf/bJGiExAa++xw/8QvG1DHS0vZLwlo/TnEygG+NNpXo3DdaJAVVoESwF8e
tz0uKNgBgt9QIx2ZRxRiebIjBA+bpOavCudSOlNwitOoiulffqVLbzQ9aZwo8uJJ
LksiHyYasvA7lW+6dw+DjOTv0yctUyWOfMPoj5V9GaxT41fBbCMd80XO6jxS6Y4v
tHe5BNXH2fgX8M4gZFdDXlC6XOw2/lYvONyHsPPR0ZSFYHii8SSu2yaZYJdjudrX
5hAp3F5ivklIxRhMVdpev8yBclbrHgJPrGeRD/nNa59Myh8Lml3UDs8KBOEV2n2U
nh/gUw6MTouDYI+PKZ3VEZyRIMbqIw==
=MsFr
-----END PGP SIGNATURE-----

--GpGaEY17fSl8rd50--
