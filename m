Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C3E61A0AD2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 04:45:10 +1000 (AEST)
Date: Tue, 12 May 2015 19:44:54 +0100
From: Mark Brown <broonie@kernel.org>
To: Zidan Wang <zidan.wang@freescale.com>
Message-ID: <20150512184454.GR3066@sirena.org.uk>
References: <cover.1431337606.git.zidan.wang@freescale.com>
 <1431339894-4248-3-git-send-email-zidan.wang@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="tV/+6PImfyFtriLg"
In-Reply-To: <1431339894-4248-3-git-send-email-zidan.wang@freescale.com>
Subject: Re: [PATCH 3/3] ASoC: fsl_sai: add 12kHz, 24kHz, 176.4kHz and 192kHz
 sample rate support
Cc: alsa-devel@alsa-project.org, timur@tabi.org, Xiubo.Lee@gmail.com,
 tiwai@suse.de, linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
 perex@perex.cz, nicoleotsuka@gmail.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--tV/+6PImfyFtriLg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 11, 2015 at 06:24:43PM +0800, Zidan Wang wrote:
> Normally we don't support 12kHz, 24kHz in audio driver, alsa didn't
> have formal definition of 12kHz, 24kHz, but alsa supply a way to
> support these sample rates. And add 176.4kHz and 192kHz support.

Applied, thanks.

--tV/+6PImfyFtriLg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVUkolAAoJECTWi3JdVIfQEgEH/1k7Q6FdaGYIhhfle/Mn/lB/
vEBMvzmoUp+gfa139n8gu8nXHZQOwrNIhYRz3rlCPC3I8CpNrsyBX0JqC2e8AOe2
PTL4ftqUV+1NSwa0nqCvKIYCtqvKkVlr/W6CphK49vJW7WhLHkt4t3Z2t/NYHa9X
0cyYi4aUeVcg53dTBCVI/dqHEpeNZmyGiBmfC8zhQZQVKv31zTe7tUmTHxCUH8OB
VLSPloQ1s5QzHt52ESzG+wO2JVX8fD/H5nBgMRlBEHvdcCv+J+hyrS9iqyk46Qn9
RP4daaMIefyqkkjk1bwzcQ3ZIrJGT4LG8uuS9hznBPtvM5sXUDkx4V4pQp1cjRU=
=VWUE
-----END PGP SIGNATURE-----

--tV/+6PImfyFtriLg--
