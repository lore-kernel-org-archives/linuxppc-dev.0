Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (unknown [IPv6:2001:41c8:1:5384::2])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C00AF2C0099
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Dec 2013 22:56:26 +1100 (EST)
Date: Mon, 2 Dec 2013 11:56:17 +0000
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <b42378@freescale.com>
Message-ID: <20131202115617.GV27568@sirena.org.uk>
References: <1384532729-6588-1-git-send-email-b42378@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="YDTWxoC2E3hrC6hC"
In-Reply-To: <1384532729-6588-1-git-send-email-b42378@freescale.com>
Subject: Re: [PATCH v2] ASoC: fsl_ssi: Add monaural audio support for
 non-ac97 interface
Cc: alsa-devel@alsa-project.org, linux@arm.linux.org.uk,
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com, timur@tabi.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--YDTWxoC2E3hrC6hC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 16, 2013 at 12:25:29AM +0800, Nicolin Chen wrote:
> The normal mode of SSI allows it to send/receive data to/from the first
> slot of each period. So we can use this normal mode to trick I2S signal
> by puting/getting data to/from the first slot only (the left channel)
> so as to support monaural audio playback and recording.

This looks OK but doesn't apply against current code, can you please
check and resend?

--YDTWxoC2E3hrC6hC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSnHVeAAoJELSic+t+oim9gXYP/iyCgeTlIkEq2tvHUKNxZoCT
tHOlo3ymeCohXd6nMUQ2bBO0NrpnLphny24jBHuLPFVps1enGqoNRU6TT8d3Pjfm
VTpi+9eTxgwF0wRsN5Lf0deKo/7iLsTtwffNw8K7ll8QNUl0YRIMwvqXIgpxr93Z
NqOYieIZsJSII5Aulw8cMu1fXeJVo66H0V6c4YUHrNKRqb+XZbIEZZJuWBzIaLXC
yqJKIEC7a5fu+hPicxTsf9LdMp/Z3fL6g7rIZq2bmiadcDAAtm97tAR8oYKDb1yt
dShn0dgTnexuamhCCfVI4iExnY70rBvOiz+Zxk3vM4Ub3YCJ5Pkr+DTQngk2Ynhw
RYX6jHjLBTDE3gBW/XTnzEQTMS4Q+1hQdy7sEsJFT6tTUOTWSRZc5A2O6WUtKUtz
j5Rpbc8yb5qCGExqFmTNUL1VlltOXzgPqGNaZljxcWJl5JwJUzxAisNXGT6rc3kM
xdUM/RtDu1nCNjaYebFBn7bpgvqT6+9BO8cCNoPCdGOIhUJRQURKasMWfyUHiQFQ
eQNAwZdYqjK1yfOQrYd9aEa8czH7BwgiYPGhsnT/GhMZloNi7ot7uPvf4XIf7a4x
LdonCKGVjt2yCrbYQ2ceZHyexBLW3R8HwxNWUHcI/hIQuAfaCpFwVQk+ton91Adw
MiDOSDbYsip7Y/0kQss7
=+D7z
-----END PGP SIGNATURE-----

--YDTWxoC2E3hrC6hC--
