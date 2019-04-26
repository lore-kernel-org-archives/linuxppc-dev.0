Return-Path: <SRS0=ImKy=S4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62308C43218
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 09:59:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CCAC20679
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 09:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="btGBSXhL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CCAC20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44r8dw0nfLzDqft
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 19:59:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=sirena.org.uk
 (client-ip=2a01:7e01::f03c:91ff:fed4:a3b6; helo=heliosphere.sirena.org.uk;
 envelope-from=broonie@sirena.org.uk; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="btGBSXhL"; dkim-atps=neutral
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44r8bz6wt5zDqfs
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2019 19:57:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vOo8M58He+Rp/gpFT2Ri+wgG6ma4Uc7r3bUF1I07ucQ=; b=btGBSXhLU7UM0TbUQfvF1b7Z+
 FLktd6FPzkP5ZJO4YrRw/YYFFDva2ogrtMgPtybxxA9HwsoeyDVGHAHg694LBOp7jwnL4Sz4GEftr
 9sinjmC9Qe90/27eYz4S/LEwGrT2FpUOApwz+Dqsy5Kt7Vs//TAGOGtNP2d2zoiyxmbYM=;
Received: from [37.205.61.202] (helo=finisterre.ee.mobilebroadband)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1hJxbP-0003gV-NU; Fri, 26 Apr 2019 09:57:07 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
 id 8F955441D3B; Fri, 26 Apr 2019 10:57:06 +0100 (BST)
Date: Fri, 26 Apr 2019 10:57:06 +0100
From: Mark Brown <broonie@kernel.org>
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH V3] ASoC: fsl_esai: Add pm runtime function
Message-ID: <20190426095706.GB14916@sirena.org.uk>
References: <0320f04ac785a6046a6f9baec591d36a4a6189ec.1555899304.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ftEhullJWpWg/VHq"
Content-Disposition: inline
In-Reply-To: <0320f04ac785a6046a6f9baec591d36a4a6189ec.1555899304.git.shengjiu.wang@nxp.com>
X-Cookie: -- I have seen the FUN --
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


--ftEhullJWpWg/VHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2019 at 02:31:55AM +0000, S.j. Wang wrote:
> Add pm runtime support and move clock handling there.
> Close the clocks at suspend to reduce the power consumption.
>=20
> fsl_esai_suspend is replaced by pm_runtime_force_suspend.
> fsl_esai_resume is replaced by pm_runtime_force_resume.

This doesn't apply against current code, please check and resend.

--ftEhullJWpWg/VHq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzC1fEACgkQJNaLcl1U
h9D8ugf/a57E7R0SaMmoq+3MoDHMiNdRtpJl6HAus9MmbdIFUbWvldlAob3AD6He
JMm76QgN0Af2NsTmLRhGAmLhrZQ2Bp+Wo/MP0lgSOrs2CdAFzseekjzOllajPGzX
1gL8JWRIYZ9fkRU6i87AaMJDctynIkGCaEhRqUbulbj0QD/0l8CJ1PfNfyugcFN8
WGEdEgD8DQ/ynwk6DUOkWC2HPiRWCB20kzZQH0b2mF6qTQL0YvAtfDot6XZQgWRV
veIRjLGv9koPdiNOOLVjN/QGD4x+op/M4w7e8SaHERWl0Yp9aUBeFUTrhFhhCWc9
qqFth3rvLMMRv/FZFgr2GMYhtAU92A==
=dqQx
-----END PGP SIGNATURE-----

--ftEhullJWpWg/VHq--
