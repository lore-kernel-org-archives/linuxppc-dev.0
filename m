Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0C4181A0DFA
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 May 2015 02:52:01 +1000 (AEST)
Date: Fri, 1 May 2015 17:51:51 +0100
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Message-ID: <20150501165151.GO22845@sirena.org.uk>
References: <1430496014-32309-1-git-send-email-k.kozlowski.k@gmail.com>
 <1430496014-32309-3-git-send-email-k.kozlowski.k@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="aKTE1b/cJViV0G00"
In-Reply-To: <1430496014-32309-3-git-send-email-k.kozlowski.k@gmail.com>
Subject: Re: [PATCH 3/4] ASoC: fsl: Constify platform_device_id
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


--aKTE1b/cJViV0G00
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, May 02, 2015 at 01:00:13AM +0900, Krzysztof Kozlowski wrote:
> The platform_device_id is not modified by the driver and core uses it as
> const.

Applied, thanks.

--aKTE1b/cJViV0G00
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVQ68nAAoJECTWi3JdVIfQyuoH/jdUX9612tajqc3lmGrV7vyT
ciNYRyyYFUMUqJLeVFRDuo+Q6i3PwRjBSC6yPoWv1+MPgJZeQLCzA9yQCt2xCrij
TiNPscnvgJybXsJ2QR+FzoH8M0PbtykVDI6gUSeXD7hAjfQFItTEX7l9CZbhGqLN
0VYyE0YtjvFoTcRGCX+MxoXNV0sBWBpKgRZvD6tt5KAfMKfG/E1VbRmj+lgpIh2C
mOzxwsvu+zoLczb33x7V+y7rYCx+nSQVtUJOaVvCPqzjD7DxxyH6S/ir5OEmtMrC
b9RlUioM9WghI/OVTyPK9RVZNLdyQW5T3kZYJXi5Bn7/nAMW+3karfLPetCTMCM=
=995z
-----END PGP SIGNATURE-----

--aKTE1b/cJViV0G00--
