Return-Path: <SRS0=nuQA=B5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4043CC433E3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Aug 2020 11:18:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0DAD206DA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Aug 2020 11:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KYFycYPr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0DAD206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BWldh6d5hzDqw1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Aug 2020 21:18:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=broonie@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=KYFycYPr; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BWlbW69StzDqj1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2020 21:16:39 +1000 (AEST)
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5684C206DA;
 Wed, 19 Aug 2020 11:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597835796;
 bh=7W9fpcvvq7j01lnjxB+ot2Sjfmr0kSAadp/9/zh9zI8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KYFycYPrBmWJam7NZKlptYCrkATXPMfUZP8OeD/6IsUDDnwM3EZ+M8LtZo3dxa5MM
 o/70hVNLqh/t6/PFzXCYwmcyA3H0CDzXRx746GYHbFq1+Abwss1s56TFmWKJCwjlzU
 AkugyyZ82ocFQMeBShPmU03BW3dtBoaed886yk5U=
Date: Wed, 19 Aug 2020 12:16:05 +0100
From: Mark Brown <broonie@kernel.org>
To: Allen <allen.lkml@gmail.com>
Subject: Re: [PATCH 00/10] sound: convert tasklets to use new tasklet_setup()
Message-ID: <20200819111605.GC5441@sirena.org.uk>
References: <20200817085703.25732-1-allen.cryptic@gmail.com>
 <s5hsgckl084.wl-tiwai@suse.de>
 <20200818104432.GB5337@sirena.org.uk>
 <CAOMdWSK79WWsmsxJH9zUMZMfkBNRWXbmEHg-haxNZopHjC1cGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XWOWbaMNXpFDWE00"
Content-Disposition: inline
In-Reply-To: <CAOMdWSK79WWsmsxJH9zUMZMfkBNRWXbmEHg-haxNZopHjC1cGw@mail.gmail.com>
X-Cookie: I wish you were a Scotch on the rocks.
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
Cc: alsa-devel@alsa-project.org, Kees Cook <keescook@chromium.org>,
 timur@kernel.org, Xiubo.Lee@gmail.com, Takashi Iwai <tiwai@suse.de>,
 linux-kernel@vger.kernel.org, clemens@ladisch.de, tiwai@suse.com,
 o-takashi@sakamocchi.jp, nicoleotsuka@gmail.com,
 Allen Pais <allen.cryptic@gmail.com>, perex@perex.cz,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--XWOWbaMNXpFDWE00
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 19, 2020 at 04:21:58PM +0530, Allen wrote:

> > These patches which I wasn't CCed on and which need their subject lines
> > fixing :( .  With the subject lines fixed I guess so so

> Extremely sorry. I thought I had it covered. How would you like it
> worded?

ASoC:

In general you should try to follow the style for the code you're
modifying, this applies to things like commit logs as well as the code
itself.

--XWOWbaMNXpFDWE00
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl89CfQACgkQJNaLcl1U
h9Cifwf+ImKkN4bcgAsq1FQIuFfGzOK1C2rJvwO1FF9QMBqoSLWbU+XXMm8B+dmp
BUuRn3yv2s26q5SMpU1EvotzyTnEdeAhS8rvA+hpUMw7E+lz9v2qz/2m553Hap6U
R1REKNzVtqstijAyYycjHID0ZsOPK+T5wBISb2fY38cJlgGRMQXh0ZgvHq54sfVK
aLts4u4J72HMFLuxPbgTfiO8CX46MjLoH0eoRzPu7R44dvzqUfzdu5B/7Fp5amcC
Sd6731MDQYarYhge1gBJ84arpbSB6Qsr1LQNh8hh2q0cXEpwNcXjnDMsYKjcoxPl
D2VS/Gxp0eqmBwQXcSE5+AGsdYKdOQ==
=XARi
-----END PGP SIGNATURE-----

--XWOWbaMNXpFDWE00--
