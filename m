Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 924361A04C9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Aug 2014 21:19:54 +1000 (EST)
Date: Thu, 7 Aug 2014 12:19:41 +0100
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Message-ID: <20140807111941.GH17528@sirena.org.uk>
References: <1407223925-29678-1-git-send-email-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Va8DSfvMR3bM4AuH"
In-Reply-To: <1407223925-29678-1-git-send-email-nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Add asynchronous mode support
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk,
 b42378@freescale.com, b02247@freescale.com, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, timur@tabi.org, Li.Xiubo@freescale.com,
 galak@codeaurora.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Va8DSfvMR3bM4AuH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 05, 2014 at 03:32:05PM +0800, Nicolin Chen wrote:
> From: Nicolin Chen <Guangyu.Chen@freescale.com>
>=20
> SAI supports these operation modes:
> 1) asynchronous mode
>    Both Tx and Rx are set to be asynchronous.

Applied, thanks.

--Va8DSfvMR3bM4AuH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT42DJAAoJELSic+t+oim9Y6EQAIWj1A+/REEmCFveYNytG/KU
ZTNjv3KXMmX8j6yRM4XaWoM0ZK6C2Mn0Lz611Xl4WVA1hlFmqzBGUQXuOqBig0rJ
hxGRYS2DmcB3Aq2IugEtyHRkdhBc+wtgVToMRHKDiaVNDBgXU8zVmp0/n9ZH3wz9
svhR4vwd1JVhl4kkn13rWTEdQdsMAbQT+kl4gQjIDRNmm8jB8XF3q6ADyQ2SqNW9
VcFnCZ0CIkReuHURw6vxNSHhLKdZD6CcMUr4f2ZujiBBcSStxI9s9jl8Cnf09XwI
h4w9SLc5SfiV+gtHCeni+j6mv7YljgnEMXibUe3/P+dhIJkzUR9F8umX6FtcHUTa
qsTjfsLGNdOFmu9aXfiBEWtEJ3E4HEl745XsixwDs4nzMtjyz7E4MCzmHfW4/gXv
Qd2vrRo69e9oAVO9hCdOv+JMFZbX8sZPKdn8VZelyK1BImf+NTgjDrWDlBVIncjd
6FlTkGZVnQs2JDIK72Ic+76NfFYuubtdietksjyh3vwbLBUgKqgk/bXf/LzuIzkC
eWU5ZhDwAgem6WTdD41cul3uFM1KAfI1ylqIsxHjQC2pfvhnD8oMQ9ZKPkB2YGrz
06IOeERo3UlLzZPgDxK0mRpA324IwhjRIMybkrh6AZR41lIZ081UeCdYxcdS/Ek7
38BqAyxYaaQkAFV5eXTU
=/x+C
-----END PGP SIGNATURE-----

--Va8DSfvMR3bM4AuH--
