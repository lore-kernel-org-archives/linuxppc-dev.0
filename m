Return-Path: <SRS0=mr1i=SM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692D4C10F14
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 10:47:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB2F420830
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 10:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="B/ld574p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB2F420830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fLTg5bFgzDqNd
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 20:47:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=sirena.org.uk
 (client-ip=2a01:7e01::f03c:91ff:fed4:a3b6; helo=heliosphere.sirena.org.uk;
 envelope-from=broonie@sirena.org.uk; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="B/ld574p"; dkim-atps=neutral
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fLJm163rzDqNv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 20:40:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HEx51tyNm/KKuDMzJyEV23nvOH993N6FZ0VSxqfZUDA=; b=B/ld574pSPkaDPJzsj8YOK4dF
 Zew7n1KBoYEvrZO3eBSDcWo/MajA0zY687koJ+1P2kpMJvurproyLy+kL9pYu1WKUb2PExNLqG6Pi
 7YQ0jY7a6h8SvakwFO02OV6nqtOfXP8TKhmdDj0SSpNeldIhkEiBpnwqdEbeaZy2Jj1iw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1hEAdw-0007mO-UU; Wed, 10 Apr 2019 10:39:49 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id CF00F1128ED3; Wed, 10 Apr 2019 11:39:47 +0100 (BST)
Date: Wed, 10 Apr 2019 11:39:47 +0100
From: Mark Brown <broonie@kernel.org>
To: Viorel Suman <viorel.suman@nxp.com>
Subject: Re: [PATCH v3 2/4] dt-bindings: fsl,audmix: remove "model" attribute
Message-ID: <20190410103947.GH6106@sirena.org.uk>
References: <1554892629-17646-1-git-send-email-viorel.suman@nxp.com>
 <1554892629-17646-3-git-send-email-viorel.suman@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Hlh2aiwFLCZwGcpw"
Content-Disposition: inline
In-Reply-To: <1554892629-17646-3-git-send-email-viorel.suman@nxp.com>
X-Cookie: teamwork, n.:
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
Cc: Mark Rutland <mark.rutland@arm.com>, Viorel Suman <viorel.suman@gmail.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Julia Lawall <Julia.Lawall@lip6.fr>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--Hlh2aiwFLCZwGcpw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2019 at 10:37:30AM +0000, Viorel Suman wrote:
> Remove "model" attribute.
>=20
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

--Hlh2aiwFLCZwGcpw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlytx/MACgkQJNaLcl1U
h9DvXwf/ZeIIHmvAomjnHuuJMUPoTAbgbUldCg3l5vaAJESfKTc/zCNHpH3ENXOc
0faIgAzQrF1At/4fAY6pJkIKAEcR/ryaIwPDk7BHfMyfoW8V+6IBu1z33JqOAhYa
XPPz30TZC2X123j8SvKdULu0GxtRRCaaCnoYWVyKCeLsjeBbPJ08AUvQ8QsuGnDU
0tv7lTgds05v8WZ8zeN0hUWoEAz2yHy9Wm9kymOgaAoIZRZARWYQTnCZDoLp5AW7
B9G3ecNhiZu2M8/6TqFtlpeuo7mJTcNL5+N5wWhy5SgtqQjmZdq3uyfyQY3b1Xhk
QNON31ljdlbbQFw83Wf7AsodJUybAw==
=C5Bl
-----END PGP SIGNATURE-----

--Hlh2aiwFLCZwGcpw--
