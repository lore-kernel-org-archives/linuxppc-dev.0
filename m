Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 213391A0003
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Aug 2014 19:39:14 +1000 (EST)
Date: Thu, 7 Aug 2014 10:38:51 +0100
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Message-ID: <20140807093851.GB17528@sirena.org.uk>
References: <1407230421-20953-1-git-send-email-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="t+aXE7hLC8APFkG0"
In-Reply-To: <1407230421-20953-1-git-send-email-nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Initialize with software reset
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


--t+aXE7hLC8APFkG0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 05, 2014 at 05:20:21PM +0800, Nicolin Chen wrote:
> This patch adds software reset code in dai_probe() so as to make a true init
> by clearing SAI's internal logic, including the bit clock generation, status
> flags, and FIFO pointers.

Applied, thanks.

--t+aXE7hLC8APFkG0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT40koAAoJELSic+t+oim9KpYQAJlYBddSHjSnX4yqwAZKyQcd
9EWSfckY5xV9Ci+qiSCbJ7GIcOsHunIqyReBvlF3KwshyKjNo0OmTVWh8fZ6L+gI
pc13E/Yu/iW7h8QJN3klEI38ZxXD6RgMec1pLCU0IvYs/zUFTUzCHNKGCFceRaHN
vV4nE/JC8Wz8Pbie1+rBmZOxgP1jQ1VcSMDLNGZhZOTJyhaf0O+idoJeVKcN6buE
reZOq4Ede8tt++G+u6Xwna1BFwT/xOnsCtrEn7Ev8Ou35237tB9mTwtQycP4YUGz
5SLc+QJfasR7Lou5bnUFl4T3fvO6JjyWvMCjskLLzn7fWM3DBO1HCiYFJMV6ZCUG
/KgXxTuSA5V9BcvaZx6XmsZ5rnq88zas8eJkxyD6noICor9OCdp8+sRV2Pmx9Z8N
aDjVe58mhU3B5g0MHi51BLWKkrT5J9S63NSqvi2TLMLzdHEPPTdA4aP4zrlriL3x
9fnTBZB9rdC7I+j0vjsILn1bZFGiz9Mly1TCXOHS7crWie2P6nGGTt8/AdULWoo8
PP12ucY2wQaOY2MnSb88VV7wtQafMhrilDmkJm0mQH0li/IVeiJII9niVrXQjcQb
dayUqWYvMtKWV/xwj6ZpHYWtNEoU1k/A39W7t4PwDTwjCTcwMQUvVYNC9dS8Q9VV
KogLUWEJ9UfV393gQBHd
=pV9C
-----END PGP SIGNATURE-----

--t+aXE7hLC8APFkG0--
