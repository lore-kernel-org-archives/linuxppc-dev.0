Return-Path: <SRS0=wfsy=OA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8930C433EF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Sep 2021 10:17:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A05160FDC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Sep 2021 10:17:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3A05160FDC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H5WyR3Zkzz2ypf
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Sep 2021 20:17:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=c0EJ5RdG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=broonie@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=c0EJ5RdG; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H5Wxj0KVhz2xX8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Sep 2021 20:16:40 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A9346103D;
 Fri, 10 Sep 2021 10:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631268998;
 bh=DY9aUAMbBWXj6/6sstLfJLZSxcBTc37Ktwo5jblB5ac=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=c0EJ5RdGelCNfqbVedB9LASXFUKnF5Fj99u2lkKeBiKwH8aotzLwyA9jXOFCQGNXR
 mDKshJW5sAKtcRjGLg5qVttQAdQ+mrvCafQ7D8kKzu3X6EqMvnqT7ZP5rUtKHq44UQ
 AnkQe9J2va7gDW2lNSBrCd32TGIEszuj3hxEM36biyod2oa3xxN01f1Gopu6Vp9OD8
 sMpcqbaCrOrHJbX4jzqLC8ZT++/1LmxujNnA/yNFzFi6hCZPuANbNreWK8kE9ThEFO
 hZUs892f1Z5SmSIyVe3Qbu7XIbE7q9qHPFF11ll50TXaOl3SHWA4juTyyx+Mj0ccQe
 69rlzRlA6S5zw==
Date: Fri, 10 Sep 2021 11:16:01 +0100
From: Mark Brown <broonie@kernel.org>
To: Shengjiu Wang <shengjiu.wang@gmail.com>
Subject: Re: [PATCH for-5.15 0/5] ASoC: fsl: register platform component
 before registering cpu dai
Message-ID: <20210910101601.GB4474@sirena.org.uk>
References: <1630665006-31437-1-git-send-email-shengjiu.wang@nxp.com>
 <20210906114701.GC4309@sirena.org.uk>
 <CAA+D8APjyq74FECmH6ZzyVKHOz6MEV0bt+D4-Xkfc-6C5n9hZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IrhDeMKUP4DT/M7F"
Content-Disposition: inline
In-Reply-To: <CAA+D8APjyq74FECmH6ZzyVKHOz6MEV0bt+D4-Xkfc-6C5n9hZg@mail.gmail.com>
X-Cookie: You are standing on my toes.
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
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Shengjiu Wang <shengjiu.wang@nxp.com>, Takashi Iwai <tiwai@suse.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Nicolin Chen <nicoleotsuka@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 07, 2021 at 10:43:26AM +0800, Shengjiu Wang wrote:

> It is hard to add conditions here for defer probe.  And maybe
> some drivers need the same components for cpu and platform.
> Do you have any suggestions?

I would expect that in this situation the same component would be able
to fill both roles.

--IrhDeMKUP4DT/M7F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmE7MGAACgkQJNaLcl1U
h9BmyAf+LFLU0qRNu/j0JR6PE/8Cy8MmuyW9DYr0CDki8qhipKQWJLaE5/l9diiL
W6V5q2giENDxPZKAyyHs08abuAq9JD0EEQu7z03P9x2UWrLxhcJ8itPNJZixH3KX
hpfg66wdAFS6QoqdQ0qLaFYzsnXMe2Zv6x6O70ddG9hLbUT6d5OfYVPWJHvKh1+U
xM/cI74vCSkZ0LG1PvEirEPw2qGWIyS610sqjZcWNUxLTtG8s+clPXy+hsNc/Mbm
jiDFUf2Ixz5TgZDlgfJElBOz9x2QHypCVsatoXe2XW50T1TYLdUAGpvmRD2F4Y/d
cvlkwzMtFFP3/6IRvYPYReyYl2Lc6w==
=EL+Z
-----END PGP SIGNATURE-----

--IrhDeMKUP4DT/M7F--
