Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CE331140125
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Apr 2014 06:52:24 +1100 (EST)
Date: Wed, 2 Apr 2014 20:52:08 +0100
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Message-ID: <20140402195208.GM14763@sirena.org.uk>
References: <1396352049-23554-1-git-send-email-Guangyu.Chen@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="L/bWm/e7/ricERqM"
In-Reply-To: <1396352049-23554-1-git-send-email-Guangyu.Chen@freescale.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Add imx6sx platform support
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, pawel.moll@arm.com, linux-doc@vger.kernel.org,
 ijc+devicetree@hellion.org.uk, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, timur@tabi.org, Li.Xiubo@freescale.com, rob@landley.net,
 galak@codeaurora.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--L/bWm/e7/ricERqM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 01, 2014 at 07:34:09PM +0800, Nicolin Chen wrote:
> The next coming i.MX6 Solo X SoC also contains SAI module while we use
> imp_pcm_init() for i.MX platform.

I've applied this, though obviously it'd be better if we had dmaengine
support for this SoC so that it was just a compatible string update and
didn't require any code.

--L/bWm/e7/ricERqM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTPGplAAoJELSic+t+oim9WMoP/jw3mYBYR71+bc4LxmhDmoXB
ZyGam2gLtQ10yNOR/EuH9yKVXS84kw2ixKSC3fUSrlxzpK2KZgei6HvI1jHza2bU
lbJ2UP5/YgxOAqdwBPLhED100mgSkTbqyZN0YwvzimRfI39VQhKip2EmZ9CASFWt
td6DydrruAQTwceiu3gyrbQ+K/2PvwNOjRHR7eRplYyM7BpJXRfYrBuy/5EhbJNJ
X1lZ6tMrIt/ILbHw/3cWS3J+nfKdevY2IUOtipUekj6jO8PeK4VdqT7oXGg1qUvT
A6IlMLiERc0Y5H6zlP6RA2MKShbh/6qfuJqvJ3pvwD4HnKWgmEIMgGpEmrzUtLRV
SwYP+L7j7diZJNkD2T3EtlfSXaJzoEHiVEHZeV1vqgiq6E5YY2D/dJZPl2s5Y7vZ
E5c7s0IOvH0Dr5YbJ9cvU5oQbu13mBTJ/eitqSWzQwR5/rjpi8b27SRBzgovAGzZ
UIbKP0hpTLHU0c1M26twq5OTIPlBBeuNZjjcKeCPC5hg3PuvLvPNSa9d1W1icFl1
/LWv5WYiB3OLFdzhQThZk1RMjjCAdQFusOBS7wUqGlPkolr7GVUz+TGLzFYxnpbM
28o17R2LOjA6CfiQenkuz7kubgSAKI7LKTjyc/aV2xAMAIrO0sbOXWjUczVcrHic
l+yze0UTzoGYtvc3ipr2
=5s9g
-----END PGP SIGNATURE-----

--L/bWm/e7/ricERqM--
