Return-Path: <SRS0=ZLNG=CD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B9FC433DF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Aug 2020 12:14:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00A6C20706
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Aug 2020 12:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtoEFfPQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00A6C20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BbSbM5d84zDqSg
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Aug 2020 22:14:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=broonie@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=NtoEFfPQ; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BbSXF2b1CzDq97
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Aug 2020 22:11:40 +1000 (AEST)
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B355920706;
 Tue, 25 Aug 2020 12:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598357498;
 bh=lLcZy5Wo6jWvC7rPiDhmximohADFk1jbAXM/KoH5hVQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NtoEFfPQ4QExLDKzsR29XM4M/Hv+Kf1cudKSei+JdGaz0fTh1snxnWmUmgHiCwQJi
 WPgVVcN4Pu2OE2jRcg8B69zc0BULmNtSPu9Z/m7CPUYkS5AZ7faPAbV5PL4t7IyHXy
 6yW0DhQ13Ay17zkd3EdsQTxsjBq5yQ242NBffaf4=
Date: Tue, 25 Aug 2020 13:11:02 +0100
From: Mark Brown <broonie@kernel.org>
To: Yu Kuai <yukuai3@huawei.com>
Subject: Re: [PATCH 1/2] ASoC: fsl: imx-es8328: add missing kfree() call in
 imx_es8328_probe()
Message-ID: <20200825121102.GF5379@sirena.org.uk>
References: <20200825120531.1479304-1-yukuai3@huawei.com>
 <20200825120531.1479304-2-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="twz1s1Hj1O0rHoT0"
Content-Disposition: inline
In-Reply-To: <20200825120531.1479304-2-yukuai3@huawei.com>
X-Cookie: Don't get to bragging.
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
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, timur@kernel.org, Xiubo.Lee@gmail.com,
 yi.zhang@huawei.com, festevam@gmail.com, s.hauer@pengutronix.de,
 tiwai@suse.com, lgirdwood@gmail.com, perex@perex.cz, nicoleotsuka@gmail.com,
 linux-imx@nxp.com, kernel@pengutronix.de, yukuai@huawei.com,
 shawnguo@kernel.org, xobs@kosagi.com, shengjiu.wang@gmail.com,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--twz1s1Hj1O0rHoT0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 25, 2020 at 08:05:30PM +0800, Yu Kuai wrote:
> If memory allocation for 'data' or 'comp' succeed, imx_es8328_probe()
> doesn't have corresponding kfree() in exception handling. Thus add
> kfree() for this function implementation.

> @@ -151,7 +151,7 @@ static int imx_es8328_probe(struct platform_device *pdev)
>  	comp = devm_kzalloc(dev, 3 * sizeof(*comp), GFP_KERNEL);
>  	if (!comp) {

The allocation is being done using devm_ which means no explicit kfree()
is needed, the allocation will be automatically unwound when the device
is unbound.

--twz1s1Hj1O0rHoT0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9E/9YACgkQJNaLcl1U
h9By5wf9GsLAxwbWBAbrnKCxyu9PM9ucYMMERlrYpCaWXat0bBzG/zblA6fGcCVd
UtSA/ON7K+KTqqXX7wYEK1HebOUSfemHcJDZ9OvUfpFkswXpZqkhAmcm4n4wZ0Jo
ARFpyf9ifjltEU43SfqNs9iwVW6Dj/RXghoQ6/iTh4vzXokipE6IuXiPNnxsJ09g
SjeN6JJJe0SLYLhPIcrPb7tSIv5ZB5no846dUSUdgpxKN7g0G3nGFeQjYjh63P1u
ghEhEfq9nUvhjfMZmajC1CtiUjrgf+Y+3eXDByE0p/goE9PH/nQbgTYOsHoSEExC
BviLGNDWPywLcqIgIv9fsj+ewCVfVg==
=kko3
-----END PGP SIGNATURE-----

--twz1s1Hj1O0rHoT0--
