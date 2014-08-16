Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 87FAB1A003D
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Aug 2014 07:33:17 +1000 (EST)
Date: Sat, 16 Aug 2014 14:40:37 +0100
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Message-ID: <20140816134037.GI28623@sirena.org.uk>
References: <1406719658-20937-1-git-send-email-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="h22Fi9ANawrtbNPX"
In-Reply-To: <1406719658-20937-1-git-send-email-nicoleotsuka@gmail.com>
Subject: Re: [PATCH RFC] ASoC: fsl: Add Freescale Generic ASoC Sound Card
 with ASRC support
Cc: fabio.estevam@freescale.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, shawn.guo@linaro.org, timur@tabi.org,
 tiwai@suse.de, b42378@freescale.com, b02247@freescale.com,
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com, Li.Xiubo@freescale.com,
 mpa@pengutronix.de, perex@perex.cz, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--h22Fi9ANawrtbNPX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 30, 2014 at 07:27:38PM +0800, Nicolin Chen wrote:
> The Freescale Generic ASoC Sound Card is a general ASoC DAI Link driver that
> can be used, ideally, for all Freescale CPU DAI drivers and external CODECs.

Applied, thanks.

--h22Fi9ANawrtbNPX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT719SAAoJELSic+t+oim99cEQAJFas+ffvanUkBZGtzot3rRa
k3xbLiGrtdYVzOY5yIcvseJAKWC44wOlscyyyNbNH6+3NktiuVQ9ck42cXXUhS3D
Xic4/FYeJexPqNf5YXdhmdxzOVrUKX8ffNU/9AqGjSdPDn+bAolnS8pGdIN/s3n/
ed5ssVtYSjuO9eulL8wbm6/nqTTLfzat10sFBjBLEobd1VupCn82E16N9Z6Q0GY3
VR61YStlPSFp2zPCJnoWth8YTKPT9AbddqUTyLe6rC5Kz+NzxEpewi0v5QTP4uI7
7RQI+BqG1lta+DwydXfXPdPtal8pgx9Jfuui8z3oKpE2U+TRYD6UipmAy4FebY1F
8i07Wj9xWiQYJitj5wCP7J5SFAOEf87cQ0UtLtxpIDixq8AwV3d40juRlTD9Py0k
Wze8wajIDFbHE28egxxhKyIUwVo5qIV2AOL6C77R1xVuhyWXHnePs0kULZqDouwx
iGICuJVvU39Z2KMdD6ks3TrCaVX3zIN5SPfd+26fUDK2waqDIWQVI7+1BVLZszlc
pH2QjTu5q9lr4cPGxhoHHYe3Czvn8HIVO/aUBvrY8FYMUJCrU1RdwGPsClTP/cP9
t5hTEPC2sxRVmm3kxcBVEkGhj0KcoHl7L7Fk6L51Lne9RWe+uTiQanXWaqH1PoBj
G4WVo84eHsC64XhYFFvR
=hkzF
-----END PGP SIGNATURE-----

--h22Fi9ANawrtbNPX--
