Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A006F1A002E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Jul 2014 05:50:40 +1000 (EST)
Date: Wed, 2 Jul 2014 20:50:30 +0100
From: Mark Brown <broonie@kernel.org>
To: Zhao Qiang <B45475@freescale.com>
Message-ID: <20140702195030.GR410@sirena.org.uk>
References: <1403753203-13473-1-git-send-email-B45475@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="wc6dtGz1CZgs+5WP"
In-Reply-To: <1403753203-13473-1-git-send-email-B45475@freescale.com>
Subject: Re: [PATCH v2] spi: deal with a compile warning
Cc: B07421@freescale.com, linuxppc-dev@lists.ozlabs.org,
 linux-spi@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--wc6dtGz1CZgs+5WP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 26, 2014 at 11:26:43AM +0800, Zhao Qiang wrote:
> ret is unused when CONFIG_FSL_SOC defined,
> so return ret instead of -ENOMEM when the
> kzalloc fails to avoid it.

Applied, thanks.

--wc6dtGz1CZgs+5WP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTtGKDAAoJELSic+t+oim9issP/R58ta/q9aDpEMjXxVAMQbHR
NQ5Z9su/lm5iekuJwANYAZjCU6fXvNgLZrz7+EH5QpU5M3loAeAEoL1qGh977Sgj
uBWFapVBFBKgQEl6yq+WZpUep2rjaTqFdAxccJdgnFlnSVzFlZlr0oP/3awnFsNH
9N/BLLm0T8igGb0TbLpRkb6xc9N4v01Usq6YLvkoI95UyUOqRy8BrGMVhNyO2Irb
jOL8kWV0APX2i/eAmaw8oC4nS8CqjJjcNy9FsJ9TX0G2NwBo4slmOmlAwt0Md0nO
HR/cFvjG2BLYjaImVGt3nSl3ex7sVRnxoPwmQuHVe6wiELRqlwsgSpikdSSK1ZD/
S6ndzf73bILS05tIsQfj3d1HxRfXta6VUYmgPJL+Y+u61xi3jZ6ANuRN6pn0/tjh
JDM05KOaIwT7jKK9j2lIVnPeIzcWYAx72xJ93tmaraDRE7ZBwcRgFsAyXgAOPxjr
G/QmgZQqyjJ8vgpv013fVd4tY6hYqgDoCwatGwk6ETnkKnGk4S+g/L/qbXh+uL+I
EdhqQ4aWMbOIIeE3wds57ISBgV2w1KSBowRivrpwVlXc32hcwOFpImVLoj+uXmwq
XbKMiZBMT8wzZHWTSBp6XZVa7DpPzwNGItlGVqVcRPpz6Th1iwmAQ1j7SV0NY55V
eEiXZ3SqlbZFmGIlr/V4
=LWdR
-----END PGP SIGNATURE-----

--wc6dtGz1CZgs+5WP--
