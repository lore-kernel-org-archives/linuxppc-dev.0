Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E6E4A1A016F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Oct 2014 04:31:11 +1100 (AEDT)
Date: Mon, 27 Oct 2014 17:30:31 +0000
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Message-ID: <20141027173031.GA18557@sirena.org.uk>
References: <cover.1414193668.git.nicoleotsuka@gmail.com>
 <1414194502-14052-1-git-send-email-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ds9maZbwT7uk2FVi"
In-Reply-To: <1414194502-14052-1-git-send-email-nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl-asoc-card: Don't bypass settings if cpu-dai is
 Master
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, b02247@freescale.com,
 linux-kernel@vger.kernel.org, timur@tabi.org, Li.Xiubo@freescale.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--ds9maZbwT7uk2FVi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2014 at 04:48:11PM -0700, Nicolin Chen wrote:
> When cpu-dai is the DAI Master (CBM_CFx), it may need some configurations,
> set_sysclk() call for eample, for cpu-dai side in the hw_params(), even if
> the set_bias_level() has already taken care of the codec-dai side.
>=20
> So this patch just simply adds an additional condition.

This was threaded with another patch series - did you intend to submit
this or did it get sent by accident?

--ds9maZbwT7uk2FVi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUToE2AAoJECTWi3JdVIfQTYkH/1COldDWplbfTUcsM/7aE54g
Z62JNqf6aaYMuFKyDAPXuXW6IC/KsSGLvj7eR1vT1sf4NUZSQ5qGf9LdJ4CCM//p
W/jVvoYIYSLT/erZw/t/r1QgPkmC/Vt2VdmzwqvM7cIafq5/M6drIoGru8fv4wE8
luR4Aq6Y+gqsVE8c9u6CMAumsXushHQUcDBgd0QoYVIGhuATLpV+PRVfUer9bWWg
vBjsU3KNaOU9CLOsa3tUTNoFLSSyOlUK6lcueySAkGpyvMyZ6kzhAszMDiz2m8/F
p58A6YUOX+SteJGXW2dc1sZW1a4sP0PIyM9xrCHJJRsBtRJtgC0bz/6NXB+EcBo=
=Ykv5
-----END PGP SIGNATURE-----

--ds9maZbwT7uk2FVi--
