Return-Path: <SRS0=ts8b=SV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47B4C282DA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Apr 2019 15:27:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB289222D1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Apr 2019 15:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="TuVsJDeY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB289222D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44m0FY2VLnzDqTm
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Apr 2019 01:26:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=sirena.org.uk
 (client-ip=2a01:7e01::f03c:91ff:fed4:a3b6; helo=heliosphere.sirena.org.uk;
 envelope-from=broonie@sirena.org.uk; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="TuVsJDeY"; dkim-atps=neutral
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44m0Cf1MsvzDqTZ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Apr 2019 01:25:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CR0l63MsMkbpSElEofDsa9+rQQWzCQ5B3utGWeqKvco=; b=TuVsJDeYTMOrdR3CxkNl30bQ1
 hpRroV5TZAolAnMG18k9U7TGYcmLHVfcPcjc75G3RsLVzrloIwlRHGUpT06dmQ46QfwrVGxnQzxfD
 4MsEcqkkhI0Skn1hsFAxwA4d3UGFKUOYWrTzYwjCTtB6m88HwPXE1oA8TVqx2ezT6KaZc=;
Received: from 188.29.164.213.threembb.co.uk ([188.29.164.213]
 helo=finisterre.ee.mobilebroadband)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1hHVO0-0008Io-Ox; Fri, 19 Apr 2019 15:25:08 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
 id 35253441D3B; Fri, 19 Apr 2019 16:25:07 +0100 (BST)
Date: Fri, 19 Apr 2019 16:25:07 +0100
From: Mark Brown <broonie@kernel.org>
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [alsa-devel] [PATCH V2] ASoC: fsl_esai: Add pm runtime function
Message-ID: <20190419152507.GU2803@sirena.org.uk>
References: <VE1PR04MB6479A85982748088CC42901DE3270@VE1PR04MB6479.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4WCFFtl4AQpQKunj"
Content-Disposition: inline
In-Reply-To: <VE1PR04MB6479A85982748088CC42901DE3270@VE1PR04MB6479.eurprd04.prod.outlook.com>
X-Cookie: Shah, shah!  Ayatollah you so!
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
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--4WCFFtl4AQpQKunj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2019 at 11:01:21AM +0000, S.j. Wang wrote:

> > fsl_esai_probe(struct platform_device *pdev)
> >                 return ret;
> >         }
> >=20
> > +       pm_runtime_enable(&pdev->dev);
> > +

> I just have a question, do I need to add pm_runtime_idle(&pdev->dev)?

It gets used to help drivers get into the correct state on startup, if
you're unsure if it's 100% required it shouldn't hurt.

--4WCFFtl4AQpQKunj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAly56FIACgkQJNaLcl1U
h9CGCwf/V4SKmPiu420k0g+uofTrLtN6Jv9aTQuGhf7zO7AX1stWXlkVwZwj6RZK
XC7w1TLKHMVSJUp+U5nUKH9lrbIPsldykON2Mn1cK7TQRIXMXoXgZgBZRagddQkU
iP0RupSAma6LT4/o4RHV6pjp2qDMU8oJfIUcBqiyFQsmaEMvYK14izz7hOScKwIb
VZMnFG60t8T7AxVCKda6cW72ikkuV1pvAENJ2j36iTNfaFA9Ufo/du99PNZK+9bW
o34ZkH1FrcKZRgM0gQ3icbYUxQQV+WflxfFayC4M/qfCXjJiVoAbvEpLzfSSVYtW
Irvy3o+JKq311kA8vioI3gdp9HFhUg==
=6lYl
-----END PGP SIGNATURE-----

--4WCFFtl4AQpQKunj--
