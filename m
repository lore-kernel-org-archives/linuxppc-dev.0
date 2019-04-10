Return-Path: <SRS0=mr1i=SM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8138FC10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 11:21:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0166E20818
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 11:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="sCXP4EKH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0166E20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fMCw5lLTzDqJT
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 21:21:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=sirena.org.uk
 (client-ip=2a01:7e01::f03c:91ff:fed4:a3b6; helo=heliosphere.sirena.org.uk;
 envelope-from=broonie@sirena.org.uk; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="sCXP4EKH"; dkim-atps=neutral
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fM2l3HqnzDqGZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 21:13:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uEPgs07wAvANBUnRzE5ezosnYqWGzwyUUd8p6lScjt0=; b=sCXP4EKHX8L0o3bM1aJqOBzDS
 I72JZ3Lzs52C/edc8kycc1ZXIze7YTrw+/ke6QhyYIvl7KIhUIDuBMeycvgpBBp9RtM5JCVXYASZE
 Ec0MFP7H19IkUWm8eNDhG5zaALKNByx6L3jpbQs+Tr4WIePU0U3SFBD68MgywHcywDbDc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1hEB9s-00080u-UB; Wed, 10 Apr 2019 11:12:49 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id 911C21128ED3; Wed, 10 Apr 2019 12:12:42 +0100 (BST)
Date: Wed, 10 Apr 2019 12:12:42 +0100
From: Mark Brown <broonie@kernel.org>
To: Viorel Suman <viorel.suman@nxp.com>
Subject: Re: [PATCH v4 0/4] ASoC: fsl: audmix: remove "model" attribute and
 fix ref leaks
Message-ID: <20190410111242.GK6106@sirena.org.uk>
References: <1554894380-25153-1-git-send-email-viorel.suman@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8tUgZ4IE8L4vmMyh"
Content-Disposition: inline
In-Reply-To: <1554894380-25153-1-git-send-email-viorel.suman@nxp.com>
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


--8tUgZ4IE8L4vmMyh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 10, 2019 at 11:06:35AM +0000, Viorel Suman wrote:
> The latest audmix patch-set (v5) had the "model" attribute removed as
> requested by Nicolin Chen, but looks like (v4) version of DAI driver
> reached "for-next" branch - fix this by removing "model" attribute.
> Asside of this fix object reference leaks in machine probe reported by
> Julia Lawall.

This is the second version sent out in the past hour or so :(  Please
allow a bit more time for review and comments, people might still be
looking at the earlier versions so any additional changes they spot will
result in yet another resend and more noise in people's inboxes.

--8tUgZ4IE8L4vmMyh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlytz6kACgkQJNaLcl1U
h9CQWAf/d6PbLwI/eE3Z3GqFktngflv/Hvwe+3XW8M8gaoXqCol86/BusJ0fGnQL
S/cqap0+yT+My2oovt3KCTAqtA/CssjrlYvqyEbsC8pMGvewtVAMzUFaMbrLUnOu
aJEp7Fq9wCAT0Q/mM5TiFGrVBpmQlIpthIOP1wLejUesGpQLlPM0bNXhbCeBc1u/
rjB07FvCZrnEdVtO5ohtB6HPsD71lUqejGrxMr56T5tU6nAhT7ksfXyD4uRv8Wrh
/l/DGCYxBqKdHNEw5Fi2mj/2+9f5vS4uO6oJ6xa/RGfJKrXqrZupqn+OPQZ084OA
BEA0nh6cJQ2V9rnxrtcp3sVwHxTPHw==
=9K0N
-----END PGP SIGNATURE-----

--8tUgZ4IE8L4vmMyh--
