Return-Path: <SRS0=FKTu=AN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2F8C433DF
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2020 14:36:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F2E720899
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2020 14:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rh0X/EYu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F2E720899
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49yLHt60smzDr15
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2020 00:36:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=broonie@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=rh0X/EYu; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49yLBw2BPpzDqW1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jul 2020 00:31:51 +1000 (AEST)
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1424320890;
 Thu,  2 Jul 2020 14:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593700307;
 bh=yoiiIk8yV7aQeMBE6eGjgWhzrgZn5o4MtsX81urPOGs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rh0X/EYuSOXjJd7IZLHAt5PjkHiHVaHXBUckRAW9ESHhInCw6Awe+B4EfTXfWCHVB
 7EktAmVfcIb68os9+HU0zTIMMK2vVgmbUxpjkhl/15jB1bAUYaB/mh6tZxA+Kca9Kt
 8pgI/1MrVOnWgvLgGpKz3zSZFCNbIk1mawQLAFq0=
Date: Thu, 2 Jul 2020 15:31:45 +0100
From: Mark Brown <broonie@kernel.org>
To: Arnaud Ferraris <arnaud.ferraris@collabora.com>
Subject: Re: [PATCH 1/2] dt-bindings: sound: fsl-asoc-card: add new
 compatible for I2S slave
Message-ID: <20200702143145.GG4483@sirena.org.uk>
References: <20200702141114.232688-1-arnaud.ferraris@collabora.com>
 <20200702141114.232688-2-arnaud.ferraris@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/Zw+/jwnNHcBRYYu"
Content-Disposition: inline
In-Reply-To: <20200702141114.232688-2-arnaud.ferraris@collabora.com>
X-Cookie: I'm rated PG-34!!
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org, Timur Tabi <timur@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, kernel@collabora.com,
 Fabio Estevam <festevam@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--/Zw+/jwnNHcBRYYu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 02, 2020 at 04:11:14PM +0200, Arnaud Ferraris wrote:
> fsl-asoc-card currently doesn't support generic codecs with the SoC
> acting as I2S slave.
>=20
> This commit adds a new `fsl,imx-audio-i2s-slave` for this use-case, as
> well as the following mandatory properties:

Why require that the CODEC be clock master here - why not make this
configurable, reusing the properties from the generic and audio graph
cards?

--/Zw+/jwnNHcBRYYu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7979AACgkQJNaLcl1U
h9AxkAf/ayvMQ6Irjwi6oOAqWBxCV2VEySnpQQvROq2t4wDxz2MOOXIE0fZfwg0F
I7UlRDnm9ZyWwq8Dol9pigToIxzfz/G0rxJ0F3jTr5qo/1lt+hFMmdlghcl0T37v
4OP2CPBwJtmavd2mM06870/eXQKtmd3jwRXJ2HKljt9ZSuHVcyOk0t+ZaR0zYD+V
1AvChO6mvUipSO7A82pchm57qOKdBv7SpIGtHf4wsc+MFuEFJYaOtjfCwTrFvB1B
kPACxzQBG4l4xgQtN803PNAZbjbZCBGusst8v4Kpygbpq5OjuhFMJ4xHUVcxHPVk
y4i45+Yv7ceu+GohmwdxDGKnszmETw==
=uElK
-----END PGP SIGNATURE-----

--/Zw+/jwnNHcBRYYu--
