Return-Path: <SRS0=ax18=7C=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6105DC433DF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2020 12:42:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AF0E20758
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2020 12:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="y05unyyJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AF0E20758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49RspY5JVqzDqjl
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2020 22:42:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=broonie@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=y05unyyJ; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49RskR3HYnzDqFG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2020 22:38:54 +1000 (AEST)
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E16B320758;
 Wed, 20 May 2020 12:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1589978332;
 bh=g7mq7A46A2rwnilYsWelJzFIzIUJhVoiPiT9cEmHRqM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=y05unyyJD7TNaV987OdTJu89O1CnVTvMOJXBtUxxhoRdPpPwrGFOLAsPQdIHmglCZ
 /TdnyHJTd4wnRuuEc9rHwD1xbrOzJV3PPWqVGYYRc76P5MIZ6Tiib5JDErJJuforA+
 evfuyTPGebwbAc8o+UKJkiW+ST3XQhvcR1GdBas8=
Date: Wed, 20 May 2020 13:38:50 +0100
From: Mark Brown <broonie@kernel.org>
To: Shengjiu Wang <shengjiu.wang@gmail.com>
Subject: Re: [PATCH] ASoC: fsl: imx-pcm-dma: Don't request dma channel in probe
Message-ID: <20200520123850.GE4823@sirena.org.uk>
References: <1589881301-4143-1-git-send-email-shengjiu.wang@nxp.com>
 <0866cd8cdb0c22f0b2a6814c4dafa29202aad5f3.camel@pengutronix.de>
 <CAA+D8APhHvA39wmCayeCsAEKmOJ0n7qOQiT1tZmFHr4+yASgTw@mail.gmail.com>
 <53258cd99caaf1199036737f8fad6cc097939567.camel@pengutronix.de>
 <CAA+D8APAMRwtVneqFsuBgAhozmQo3R0AQi0bVdUCQO4Af4xVfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lteA1dqeVaWQ9QQl"
Content-Disposition: inline
In-Reply-To: <CAA+D8APAMRwtVneqFsuBgAhozmQo3R0AQi0bVdUCQO4Af4xVfw@mail.gmail.com>
X-Cookie: You can't get there from here.
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
Cc: sumit.semwal@linaro.org, linaro-mm-sig@lists.linaro.org,
 Linux-ALSA <alsa-devel@alsa-project.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel <linux-kernel@vger.kernel.org>, Timur Tabi <timur@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, shawnguo@kernel.org,
 Shengjiu Wang <shengjiu.wang@nxp.com>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, dri-devel@lists.freedesktop.org,
 perex@perex.cz, Nicolin Chen <nicoleotsuka@gmail.com>, linux-imx@nxp.com,
 kernel@pengutronix.de, linux-media@vger.kernel.org,
 Fabio Estevam <festevam@gmail.com>, s.hauer@pengutronix.de,
 linux-arm-kernel@lists.infradead.org, Lucas Stach <l.stach@pengutronix.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--lteA1dqeVaWQ9QQl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2020 at 07:22:19PM +0800, Shengjiu Wang wrote:

> I see some driver also request dma channel in open() or hw_params().
> how can they avoid the defer probe issue?
> for example=EF=BC=9A
> sound/arm/pxa2xx-pcm-lib.c
> sound/soc/sprd/sprd-pcm-dma.c

Other drivers having problems means those drivers should be fixed, not
that we should copy the problems.  In the case of the PXA driver that's
very old code which predates deferred probe by I'd guess a decade.

--lteA1dqeVaWQ9QQl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7FJNkACgkQJNaLcl1U
h9CQxAf/XWB/BDAkTjyNyif7eAXkZvu58koo16rODvQZScO1qMJDv7rgM7PAY3cp
oA8PM6mc2y9ilW+8iJcaRBUazw743WsZy4B8+4zgZ4S+16WavSbW/TcgoP1XHKmn
45dF0NFIESHhxVhwdmHAhRrolV6ukd4taibnCUbPFBbG3AgT7XjvOl8gQmwY5Xbr
4WC83n6SHn8es9HF2g733RvA8jAFMr+biVQ7FnsyxEhi3oMgOYF7LOQ+ZrBM69xC
49iQbno7b5fQ8cPQLKmdt5mzBp0n5anoHWFvvk1zi1RPqM+7gGMv/DBvAB8u7o+F
l8Qr1SUzhOsG/j0FDFUIriQktZ4TEw==
=CLfU
-----END PGP SIGNATURE-----

--lteA1dqeVaWQ9QQl--
