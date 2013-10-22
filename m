Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (unknown [IPv6:2001:41c8:1:5384::2])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D7F562C0095
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Oct 2013 21:09:19 +1100 (EST)
Date: Tue, 22 Oct 2013 10:47:08 +0100
From: Mark Brown <broonie@kernel.org>
To: Xiubo Li-B47053 <B47053@freescale.com>
Message-ID: <20131022094708.GA2883@sirena.org.uk>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
 <1382000477-17304-9-git-send-email-Li.Xiubo@freescale.com>
 <20131018173126.GU2443@sirena.org.uk>
 <1DD289F6464F0949A2FCA5AA6DC23F82866807@039-SN2MPN1-013.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
In-Reply-To: <1DD289F6464F0949A2FCA5AA6DC23F82866807@039-SN2MPN1-013.039d.mgd.msft.net>
Subject: Re: [PATCHv1 8/8] Documentation: Add device tree bindings for
 Freescale VF610 sound.
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "tiwai@suse.de" <tiwai@suse.de>, Wang Huan-B18965 <B18965@freescale.com>,
 "timur@tabi.org" <timur@tabi.org>, "perex@perex.cz" <perex@perex.cz>,
 Guo Shawn-R65073 <r65073@freescale.com>,
 "LW@KARO-electronics.de" <LW@KARO-electronics.de>,
 "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
 Chen Guangyu-B42378 <B42378@freescale.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "grant.likely@linaro.org" <grant.likely@linaro.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "ian.campbell@citrix.com" <ian.campbell@citrix.com>,
 "pawel.moll@arm.com" <pawel.moll@arm.com>,
 "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 "oskar@scara.com" <oskar@scara.com>,
 Estevam Fabio-R49496 <r49496@freescale.com>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "rob@landley.net" <rob@landley.net>,
 Jin Zhengxiong-R64188 <R64188@freescale.com>,
 "shawn.guo@linaro.org" <shawn.guo@linaro.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 21, 2013 at 07:24:56AM +0000, Xiubo Li-B47053 wrote:

> Yes, the "-- SGTL5000 pins:" should be in the CODEC binding.
> But, actually the CODEC binding hasn't any reference about this.

> So I added it here, but not very sure.

Please add them to the CODEC binding instead.

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSZkmVAAoJELSic+t+oim9WE8P/jOtCT9+1ZxQ8Dv0pN2DjbGa
YCyJYQMjzU/KuIl5iLZBpXqCPuccq8oZw41xr6cQbIE6lWS58g7QakJxtc3Eh/Kt
tzhXFN4hD2/Mhg4ruNRa/lV/B8V2WyHydhNyII6yLZ7x0znZHLgkkpKZNdwN0eQl
cmYQ+FlHmFujx2RaeLi5OOORNX8R0ugMjCi0ouCFQy1JoPJmXzdPnb+woM/7Gqg4
NP0lGt7G6WKF+XURykOrekbLEDZiuZixxyJv5gQYg1GWoMQdNH2pTeJbEDtlk5GB
pqB6Ib6ErS4/wQehuc4VcWIkjIZ8LH9b7VjVCs+hp25a0w0/jqq/V+sl27HNjo+f
4hz3Houy938UpKfrRE5yTC+XNroJqWPBmXwjKcGd/TuH9RQwjqD0JlO1Fpw/SZRp
H/w42KYZbX5HBvMjPxRQYuEMCIQI+SuLZJKEZehiv6CEAskW+9BnKdiZ51F50YUt
sRqa9BTZuVqaG0BmHzPRDehBDQ6kALTbAf9gK+jaoSyk1GRJlb96pGLx7XwFnv05
KMUHjv0FbYouzRla+lGOmFl4ZOk61zUpcD+jk3MFUgTAKbH50yMKKNHAMHkGqAlV
KjFy4xcssY7Pd6MA0PwAfRhLP4H/85NX5EFgHJcY95hUMpon7ZwZzmTzlBa3lbLU
b3cwlP6Hg63FtN6Mw8qa
=fjJL
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
