Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 67A991A0D4C
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 May 2015 02:54:15 +1000 (AEST)
Date: Fri, 1 May 2015 17:54:05 +0100
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Message-ID: <20150501165405.GP22845@sirena.org.uk>
References: <1430496014-32309-1-git-send-email-k.kozlowski.k@gmail.com>
 <1430496014-32309-4-git-send-email-k.kozlowski.k@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="BktmtKUJXfGkDXG3"
In-Reply-To: <1430496014-32309-4-git-send-email-k.kozlowski.k@gmail.com>
Subject: Re: [PATCH 4/4] ASoC: samsung: Constify platform_device_id
Cc: alsa-devel@alsa-project.org, linux-samsung-soc@vger.kernel.org,
 Xiubo Li <Xiubo.Lee@gmail.com>, Takashi Iwai <tiwai@suse.de>,
 linux-kernel@vger.kernel.org, Timur Tabi <timur@tabi.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Sangbeom Kim <sbkim73@samsung.com>, Kukjin Kim <kgene@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--BktmtKUJXfGkDXG3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, May 02, 2015 at 01:00:14AM +0900, Krzysztof Kozlowski wrote:
> The platform_device_id is not modified by the driver and core uses it as
> const.

Applied, thanks.

--BktmtKUJXfGkDXG3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVQ6+sAAoJECTWi3JdVIfQPkUH/AmZWavLaSNSnNx6XX1Q1hns
FFXoaPjZK6LQ3tRtPlyxj9qXjvbyOnKoNWJX04AU8/Pkq9ca/0G9fpTpSGvbCpLk
ymBImJHtPLP+JE6O3DKUuJ0/6V/ROVC1tyO7XRdjDUZRArcFriYV6H8FKa06Kxz0
r7SkAVIafPXd3AjIUB6o66PqsLwNbaNV2Rk0V2LQlgO/ChME3wHVlkAinDkJrGcO
Hgo4ROodt4LiYlQT7crdXG2pVB0L2ncF6QTeeTVfi2T/XgMVNJ9CIp7z+QZUb+Fu
h7AVD1vc3+Q5pckYZxjnmnNhfOKVg1bCgj8ASEWOgvS8+RhU9uWA0p8XycQCMiY=
=nag6
-----END PGP SIGNATURE-----

--BktmtKUJXfGkDXG3--
