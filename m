Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 745C71A0CF7
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 May 2015 02:46:43 +1000 (AEST)
Date: Fri, 1 May 2015 17:46:24 +0100
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Message-ID: <20150501164624.GM22845@sirena.org.uk>
References: <1430496014-32309-1-git-send-email-k.kozlowski.k@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="4kyyiuJNZa/POMXt"
In-Reply-To: <1430496014-32309-1-git-send-email-k.kozlowski.k@gmail.com>
Subject: Re: [PATCH 1/4] ASoC: au1x: Constify platform_device_id
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


--4kyyiuJNZa/POMXt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, May 02, 2015 at 01:00:11AM +0900, Krzysztof Kozlowski wrote:
> The platform_device_id is not modified by the driver and core uses it as
> const.

Applied, thanks.

--4kyyiuJNZa/POMXt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVQ63fAAoJECTWi3JdVIfQAjQH/A3e23pzvDBdrQiWsDNZhyrZ
IOR8OlgwM3GLe/FoHsud8RTdr38gIM8papbGpiHF69kSVB5qp/bwRvI2o+Ao0wTx
6uCnvcaUzGi2K6VWheeQsplFVmad78h19CwTGkN91NwC/e/XVjJsSzCk/y6qdiIb
DxVgpTALk9Tt+fJbnpe1lxPMIBabb4Id1xc66JFOHpKpkun0p6OmyCT8s0l4bM7S
kAu87h7BJ0gdF1uLrOdhiwKzjoOhSDRKmepzKqfpqIo2DrPNenfRbYWEpD4kwmyE
RwyugWz/NPeek3kqI1i2CjJEXSvWao8h78hgAej+0H3Y0OKFlvfTLNGgLPI7uJ4=
=rQvY
-----END PGP SIGNATURE-----

--4kyyiuJNZa/POMXt--
