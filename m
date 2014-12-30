Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C22311A0C74
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Dec 2014 22:29:42 +1100 (AEDT)
Date: Tue, 30 Dec 2014 11:29:38 +0000
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Message-ID: <20141230112938.GN11764@sirena.org.uk>
References: <1419898431-11336-1-git-send-email-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="D504LSv93hbJZH+j"
In-Reply-To: <1419898431-11336-1-git-send-email-nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_esai: Fix incorrect xDC field width of xCCR
 registers
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, festevam@gmail.com,
 Xiubo.Lee@gmail.com, timur@tabi.org, linux-kernel@vger.kernel.org,
 a_bouin@yahoo.fr, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--D504LSv93hbJZH+j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 29, 2014 at 04:13:51PM -0800, Nicolin Chen wrote:
> The xDC field should have 5 bit width according to Reference Manual.
> Thus this patch fixes it.

Applied, thanks - I also fixed the patch author up to be him.

--D504LSv93hbJZH+j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUooyhAAoJECTWi3JdVIfQsscH/2tn78KxlqXHvPwBr5UzDLk+
TQhZAiQNl57FMi65A/BbhqRNa8q+LBpwNnDHMi7rVOA8AMdsOQ4v9PxYaQZv3kb9
nb5D5borblQZ2PUssBm3VB+veix+vH6r7gzBZJ+haYJICyN71ER2/pYcN9BWw856
zqQQgEcEzC2g23vo/+c+1jpTHyHCfhfTiMi17dMJTsfmAXx9vG5vUY6bWye81naZ
rG2jbiFv/3JoHyoVt6NsETa2MVTsvDRuEcAV0YFA4QLk2MMpoaEuuWyLRpAASWTF
y0lwDMuD6i3uIRy2qWkjdGWfXUTvogldo3D+fDDt8jjzNRZhxNN7b8+doxhtcUQ=
=kztK
-----END PGP SIGNATURE-----

--D504LSv93hbJZH+j--
