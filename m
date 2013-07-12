Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (unknown [IPv6:2001:41c8:1:5384::2])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 003B02C033C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jul 2013 19:13:16 +1000 (EST)
Date: Fri, 12 Jul 2013 09:43:28 +0100
From: Mark Brown <broonie@kernel.org>
To: Timur Tabi <timur@tabi.org>
Message-ID: <20130712084328.GW24508@sirena.org.uk>
References: <1373453034-21618-1-git-send-email-b42378@freescale.com>
 <20130711165401.GU24508@sirena.org.uk> <51DEE810.3090304@tabi.org>
 <20130712035732.GA27823@MrMyself> <51DF7F4F.90707@tabi.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ulNsWUvGrZAj8PMr"
In-Reply-To: <51DF7F4F.90707@tabi.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl: Disable SSI in trigger() if
 RE/TE are both cleared
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org,
 Nicolin Chen <b42378@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 shawn.guo@linaro.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--ulNsWUvGrZAj8PMr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 11, 2013 at 11:00:15PM -0500, Timur Tabi wrote:
> Nicolin Chen wrote:

> >If I'm not missing some part of branch updating, it looks like Mark hasn't
> >pushed it to the branch yet.
> >Please test it for me. Thank you.

> I definitely want to.  Unfortunately, I'm literally in the middle of
> moving into a new house, and so everything is packed up.  I won't be
> able to look at it for another week.

Yes, that's why I just went ahead - you'd said recently that you'd be
out of action for a while and not able to test anything.

--ulNsWUvGrZAj8PMr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR38GsAAoJELSic+t+oim9DZUQAJ4WQQUxFZdPT0z37KwgeA+2
Arnby1rNs0lXX2F/wpjsUsdJItQzrotO+VRSTJvJ4Qs8S3BU2463IqXua6MethyB
BZf+GeLLVW68vAwCQXqS7YBjmJpqUhVJCjJVZfHpR9/bqE7W2iB7H+OvGNTSy242
YuVt5YduYesu4iKklVGwBforWwgD/SQScGMaEHdUlMx2EsO4O8jPC81uB3TVUSGw
ldv6Az4yELP2ImFkKH9j0IblH7OWHKAXCvRlKRsSRBX/7DwCeCODY8foxdeXJl8M
6IIZw/FgYguz3dWSPP8/eBx13Rx0RrlZ6YP9PbqoP0NkVvyPEuq/xpkolWiVe9T4
rrr83D1nBzMPIUuJ+HlkBSm1yITGl+rAljek/WDmY6BxiVmrdvqD9NiJiLQu9MMI
8KbzTqObC+FF80VxrrdxukSytOK/3Q3qevgGeD2L6lNYSRTj26qpCVbLNfVZMW3S
7NmYHoHn7ugyJFknNzrPtebTbr5HsD8Mk9dMSUaQwClAGdbFKCPn2YeW4c3PCThd
A3z1ZUdFfsSgkZh8cZMu+AThkAfVuimei3kn2xh2RPNoJ4OwniaUWjnZWhhCfb96
3TMEOgqr70sdGBxlegqm/QEDdqoxijeiZR62NlXUaS9IT2zF42DgLvfO+cSaDat9
funGXfHV+7bYWkC2N1zk
=koiT
-----END PGP SIGNATURE-----

--ulNsWUvGrZAj8PMr--
