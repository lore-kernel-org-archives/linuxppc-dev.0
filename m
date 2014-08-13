Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BCDC61A0199
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Aug 2014 21:05:28 +1000 (EST)
Date: Wed, 13 Aug 2014 12:05:04 +0100
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Message-ID: <20140813110504.GM17528@sirena.org.uk>
References: <1407494479-9877-1-git-send-email-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="eQwIhY+Mh5cQwJH0"
In-Reply-To: <1407494479-9877-1-git-send-email-nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Make Synchronous and Asynchronous modes
 exclusive
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, timur@tabi.org,
 Li.Xiubo@freescale.com, galak@codeaurora.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--eQwIhY+Mh5cQwJH0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 08, 2014 at 06:41:19PM +0800, Nicolin Chen wrote:

> The previous patch (ASoC: fsl_sai: Add asynchronous mode support) added
> new Device Tree bindings for Asynchronous and Synchronous modes support.
> However, these two shall not be present at the same time.

Applied, thanks.

--eQwIhY+Mh5cQwJH0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT60ZdAAoJELSic+t+oim9ybMP/0/F7Tr/d6KL/XbxzCsUVli8
X516T8JLDNJ0nHUoUJIR3j5zN0mOAlzXt+9OzDX3Nlf5JviVddIc14UH3xUUq/Xq
g5YFsdnyf8WFXQmhnqsdWCiifJ6WCPIwTEa5zPpNAj0Z/grVXTCRtKIkmFprNgNM
73BBkhL8mmTSj31HnVK6S6DUXUPAAlpuVcK/ynVrsP9TE//lr8Pmgb44fvqnnm1Y
k3aSr4LtkPrEojc5USyy75TnNHLy/WQY5urCbGP08ggUICyQPpQGM9p/OZ0Ob2rW
4bcOP40FfQ5M5VIqGP4OyDfWsqyC+kYI6YaJWZtz5qstuOKy9pPMRg2Pakbv0xYg
KPLU3HJQTAFuNkiPQhhXiRinJE+XoBxUqBF/fpkLrjPIPi8oKzp5c6RiTl6oI47Y
NzpF2IvkVkDYs9QsIFpJhM7o4S1YTRfQpY543UuWwIcqAE2yWahe4Ad7JcxZ+7xz
6XTnHf2l5lwj2QK3s5N/Avha/KZCLFkHuGu8swskO4Rr+92KSewVGNuBc3CSsZ3y
s8VYRePWOdISdiDYwyyUNR8Vknckq2Pi6vEjMNFts9KOIHUQixLzK3Cpo2B9i644
Vy3+yBvDpjGb+2DuIubziBoc9io8s8KVk7B+AyEcjPDcKBnyOFFhO8MNEQLiIn5J
Jcq8SjNxGE16s7X4sb+x
=afrS
-----END PGP SIGNATURE-----

--eQwIhY+Mh5cQwJH0--
