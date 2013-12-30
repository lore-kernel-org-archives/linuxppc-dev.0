Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (unknown [IPv6:2001:41c8:1:5384::2])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D6ECD2C00C9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Dec 2013 23:17:26 +1100 (EST)
Date: Mon, 30 Dec 2013 12:17:19 +0000
From: Mark Brown <broonie@kernel.org>
To: Xiubo Li <Li.Xiubo@freescale.com>
Message-ID: <20131230121719.GS31886@sirena.org.uk>
References: <1387946404-24029-1-git-send-email-Li.Xiubo@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="hrnpeiJmytOBrElT"
In-Reply-To: <1387946404-24029-1-git-send-email-Li.Xiubo@freescale.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Add disable operation for the
 corresponding data channel.
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.de,
 linux-kernel@vger.kernel.org, timur@tabi.org, perex@perex.cz,
 shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org, b47053@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--hrnpeiJmytOBrElT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 25, 2013 at 12:40:04PM +0800, Xiubo Li wrote:
> Enables/Disables the corresponding data channel for tx/rx operation.
> A channel must be enabled before its FIFO is accessed, and then disable
> it when tx/rx is stopped or idle.

Applied, thanks.

--hrnpeiJmytOBrElT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSwWRLAAoJELSic+t+oim9NzQQAJpEERFX5Z3sFpwFOVOrKEod
cCJ1SIGqsgSvp5ENbyyx4ujl2jJQBFbMD4chbFa7UbWjXvjrxbkPrwG+uk7jQlCo
f1ECZDZR8+ajt6aWmY9dnXX6nca+XUDVnYetfIvBJWUqeSpjQ31DAiEe0GKXf3gL
BNFZmT/jOXYu2aV34amlSWp/IfZ25UTCbx19YjW9DqoJdijtXV/k42gqqd5jPjlN
nHnh/FUwnr9k+Jg0CnJR3/QBErd5NU55JVAu++0XF/7jtfcLeiTHyFQBH50fXS8+
qtV+KyGRlhudDZngx/Qj04V686Mf6PDKl/LYslBwqNXI7ode5xIBgjy5nRih7htL
V68OE7sPxIHPw+ISFqznhFPCWd2Egj1fzOfBRGfbxdq9vxYkgGpxA5kW3H/VvRlK
CbhOeEM+QygOycH8iAn60wzM6VvmgPZapBunLP5PelQVHkLsKOCqWPAf0OFKJoLN
DNXE80FALerXiHmFZ/+DSBAwsLZjz+QCE7NL0F48Z8E0eVQZNbwHin6ILwx9dLZJ
iFZb8SM7UwX0XnpO9LHfO2ECdspRjpESONZbEJxEW4FJrF+c2mQiRsvGykGMH+fG
dma6QSlrQQ5YrbiwijWVQw3UYvfblXliOQapYniGeXFJ/rBAkadyAi18IguzexvK
QV5XaaKc/kEYfAn4VgJ/
=AgdD
-----END PGP SIGNATURE-----

--hrnpeiJmytOBrElT--
