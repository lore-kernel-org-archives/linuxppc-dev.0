Return-Path: <SRS0=10v2=SU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD5AC10F0E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 09:10:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9DCE206B6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 09:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="t25R1zLC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9DCE206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44lCxs0GvJzDqQP
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 19:10:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=sirena.org.uk
 (client-ip=2a01:7e01::f03c:91ff:fed4:a3b6; helo=heliosphere.sirena.org.uk;
 envelope-from=broonie@sirena.org.uk; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="t25R1zLC"; dkim-atps=neutral
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44lCsR3nLLzDqRD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 19:06:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3HIKo4TJ7arFeFGllVQWH4Zy1kee7tJAEJfaQEc9lqA=; b=t25R1zLCLQQLYZao47Wzvqc6P
 9q+MdBj3J0gRPa4hYzj6fh09E//7i+IuahGCg877ktcKJUsHvaLIlto3y3MpO9JwN7GIKj6aDi5AZ
 ZeT8syzGoVxzVX8FMWJkB9pmaOly+/cGtUTQUvy+8Kaoh9tst9dNq0VKefPpw6kyS3tLU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1hH30B-00013G-Es; Thu, 18 Apr 2019 09:06:39 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id 63DC11126DA9; Thu, 18 Apr 2019 10:06:38 +0100 (BST)
Date: Thu, 18 Apr 2019 10:06:38 +0100
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_esai: Add pm runtime function
Message-ID: <20190418090638.GA6702@sirena.org.uk>
References: <1555558152-32196-1-git-send-email-shengjiu.wang@nxp.com>
 <20190418090011.GA4028@Asurada>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
In-Reply-To: <20190418090011.GA4028@Asurada>
X-Cookie: A watched clock never boils.
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
 "festevam@gmail.com" <festevam@gmail.com>, "S.j. Wang" <shengjiu.wang@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 18, 2019 at 02:00:12AM -0700, Nicolin Chen wrote:
> On Thu, Apr 18, 2019 at 03:29:09AM +0000, S.j. Wang wrote:

> > In imx8 when systerm enter suspend state, the power of subsystem will
> > be off, the clock enable state will be lost and register configuration

> Just for curiosity, we had similar situation on imx6sx, so we
> added suspend/resume with regcache. Why will the clock enable
> state be lost too? Does CCM on imx8 (might not be called CCM
> though) have any difference? What about clock rate settings?

That sounds like a bug somewhere else - I'd expect that after resume the
clocking would be restored to the state it was in before suspend.

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAly4PhsACgkQJNaLcl1U
h9D0+Qf/Qb3ZB7++N4KWIotelaGoJliU91cFGeVtbV14n7Hb9xPZ3PzNlZBY9iYN
zhzzBdDCqWV5btb21LZ8lCcFicsKQTJieKm6Ufjrnr7SJ/9pjoOuV4JnDZ6aFucA
1krwDMkcK/ZD4Dj+favuOXRQUQ892A1Km2dp1ihRlQTIVIRyubA/7F3PQdr8ZjQl
8sLhALAl7K5u5ylLUX9SItPTJSQeVxb7V+JaHCrmVpsYP1oSu3I77DHvHPKLNK7p
JJe0CvyDco+KWEJ4VXnZVt/hkEyT8tvhlmAX37A+NxYxjyXdHQZYVNOn83FuWPo7
f2Krw/3Jy9Th/DZfw4A0/wLL+dMzDA==
=OW6D
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
