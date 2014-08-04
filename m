Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 758231A0052
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Aug 2014 01:29:48 +1000 (EST)
Date: Mon, 4 Aug 2014 16:22:52 +0100
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Message-ID: <20140804152252.GT30458@sirena.org.uk>
References: <1407136045-8940-1-git-send-email-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="j5abB2DrWbqmv6QP"
In-Reply-To: <1407136045-8940-1-git-send-email-nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Set SYNC bit of TCR2 to Asynchronous Mode
Cc: alsa-devel@alsa-project.org, Li.Xiubo@freescale.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, timur@tabi.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--j5abB2DrWbqmv6QP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 04, 2014 at 03:07:25PM +0800, Nicolin Chen wrote:
> From: Nicolin Chen <Guangyu.Chen@freescale.com>
>=20
> There is one design rule according to SAI's reference manual:
> If the transmitter bit clock and frame sync are to be used by both transm=
itter
> and receiver, the transmitter must be configured for asynchronous operati=
on
> and the receiver for synchronous operation.

Applied, thanks.

--j5abB2DrWbqmv6QP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT36VJAAoJELSic+t+oim9ABwP/3ndUI2+gdawDpjqFp0aOxaJ
87fp0zku0Hqk/rH+W4yGDj2erflkRkZz3wvfMh0cUfIACltX3VkDh2oqX94wVXy0
y5BsJOfQB3o+FFMqUsgtYIms8DMBrM6ZWoqwNNo4khnbtwwmC0ZBahCrbsGpMTUp
oALZXwBbLaR8HM9rPxYOM23qMZYi2S+3w56LYko2tE98xI6pooTHYcH4RvhgemmC
quLeG1lM/Pab6NLr5Vfnbf8dcQPoCuXMT7ql/97aAJaG+hqSgMaUXVvuEfFlALtm
cNjE9tWTtkXcak04EriQSyOXeW3WWQbkI0gb9IPehQ/Qv9deOtilgFHzOSagDjS0
U6XROBeeiJNVr1ypyAaH2dqEKc0JCZavZapwlwfX8SKLOwmT2PEIBjkgXiF1moqm
WeoDUMBcpioNkGcpDeDj7UrHQC5xYjoKn3O7IqWKZqnMDi6EpBPG1esVUc7ocz6T
jc55+ZKHEkUgTWX+ajOoO4H0TVFTTSBBpCb3ssmugNZNfaqj04WkAMkd594nxLF/
RGLDAl/v4ZgRgZCkVUbJO3A8Zz0jg03yfVbaEroWav3wJA6x86BiY8U7N4WxZo42
OzQh4udzNgvA80IIQU+dAIyIczpRoVxPUBvw3N7aOA2QQz2aAsn1x3rTlf1q/B9a
Rmy/wCcilXiBxFuWb90a
=348I
-----END PGP SIGNATURE-----

--j5abB2DrWbqmv6QP--
