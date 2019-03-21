Return-Path: <SRS0=DN5o=RY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762FBC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 14:15:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F8CF2075E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 14:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="urT2pMuV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F8CF2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Q82z0R7NzDqS9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 01:15:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=sirena.org.uk
 (client-ip=2a01:7e01::f03c:91ff:fed4:a3b6; helo=heliosphere.sirena.org.uk;
 envelope-from=broonie@sirena.org.uk; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="urT2pMuV"; dkim-atps=neutral
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Q81446pFzDqS8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2019 01:14:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9C7VP9M17Edi9ownJRB/gQsXDxQ2yXBlZa+ZjqTyVEE=; b=urT2pMuV7nONxnJyakYtAAN2m
 I2p9O1oMI/rjSU8VEGyiTw04UNAcQDT7IXVzWmgYDie0dmxnKAVThbiro8vNR462sIrz5d51GHhby
 400kgsTv4CGLDcHvwDAxu5JjnhCgqztw/9kqd4gEjjQqX1Tb9BQ6hdPB26WeIvxX0OofA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1h6ySG-0005Rp-35; Thu, 21 Mar 2019 14:14:00 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id A04B111288EC; Thu, 21 Mar 2019 14:13:54 +0000 (GMT)
Date: Thu, 21 Mar 2019 14:13:54 +0000
From: Mark Brown <broonie@kernel.org>
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [alsa-devel] [PATCH V4] ASoC: fsl_esai: fix channel swap issue
 when	stream starts
Message-ID: <20190321141354.GF5684@sirena.org.uk>
References: <f05c95e5371336a8e3b0c395dc4cef70922f0caa.1551248985.git.shengjiu.wang@nxp.com>
 <VI1PR0402MB3392C426C2F5D65322A04253E3400@VI1PR0402MB3392.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Wb5NtZlyOqqy58h0"
Content-Disposition: inline
In-Reply-To: <VI1PR0402MB3392C426C2F5D65322A04253E3400@VI1PR0402MB3392.eurprd04.prod.outlook.com>
X-Cookie: Hackers of the world, unite!
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
 "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--Wb5NtZlyOqqy58h0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2019 at 02:08:20AM +0000, S.j. Wang wrote:
> Hi Mark
>=20
>     Can this patch be accepted?  Or need I do any update?

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--Wb5NtZlyOqqy58h0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyTnCEACgkQJNaLcl1U
h9B9bQf/fXCvrAe4VwBHDEDbRf25Ej5zqtjF0y7qCYvdakFF9KQyS7I8Q04b5JZs
x0qnlJVQYUWs1Bm81uqw3Y90Pej9oQ/zxCzwt2eJjvlbRkTt2eB/1mueC0MaN6qz
x3KcDt3FvhKZZqOb6Xmy2WvgJTdp3+ySDy68Z5Hrfqo6oTTMp2IuxxBSWjpFPKBE
Swv2JRAZUb3Mp5CSEDKJ3yZEtyl58/JIud97D8UJ7jXV6YsD+EJqLqKaty22sM3C
+3l65wd2tNIEr3cQhMUpseXUmye+IGIlBKtRxQuO3V/R0NTfEyzXfKm7pzw6/hpe
VfcDZXZamrsiOl5IsNsmqdsKqM493g==
=7Mjh
-----END PGP SIGNATURE-----

--Wb5NtZlyOqqy58h0--
