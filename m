Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (unknown [IPv6:2001:41c8:1:5384::2])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AF4F42C00B1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Oct 2013 01:11:13 +1100 (EST)
Date: Thu, 17 Oct 2013 15:10:03 +0100
From: Mark Brown <broonie@kernel.org>
To: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <20131017141003.GO2443@sirena.org.uk>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
 <1382000477-17304-2-git-send-email-Li.Xiubo@freescale.com>
 <525FD4C7.3050806@tabi.org> <525FD65B.3040004@metafoo.de>
 <525FE48B.7020709@tabi.org> <525FE728.90403@metafoo.de>
 <525FE815.1040300@tabi.org> <525FEB7A.5040406@metafoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="5+z6kX2Nyw2GkWv9"
In-Reply-To: <525FEB7A.5040406@metafoo.de>
Subject: Re: [alsa-devel] [PATCHv1 1/8] ALSA: Add SAI SoC Digital Audio
 Interface driver.
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org,
 linux-doc@vger.kernel.org, tiwai@suse.de, b18965@freescale.com,
 Timur Tabi <timur@tabi.org>, lgirdwood@gmail.com, r65073@freescale.com,
 LW@KARO-electronics.de, linux@arm.linux.org.uk, b42378@freescale.com,
 Xiubo Li <Li.Xiubo@freescale.com>, oskar@scara.com, grant.likely@linaro.org,
 devicetree@vger.kernel.org, ian.campbell@citrix.com, pawel.moll@arm.com,
 swarren@wwwdotorg.org, rob.herring@calxeda.com,
 linux-arm-kernel@lists.infradead.org, fabio.estevam@freescale.com,
 linux-kernel@vger.kernel.org, rob@landley.net, r64188@freescale.com,
 shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--5+z6kX2Nyw2GkWv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 17, 2013 at 03:51:54PM +0200, Lars-Peter Clausen wrote:
> On 10/17/2013 03:37 PM, Timur Tabi wrote:

> > I understand that, but I'm trying to figure out why of_iomap() is okay for
> > hundreds of other drivers, but not this one.  I've used it dozens of times
> > myself, without ever worrying about overlapping regions.

> The driver would work fine with just of_iomap(). But the resource range
> check comes basically for free and it does help to catch errors, so I'd
> recommend on using it rather than not using it.

There's also the fact that it's a devm_ function which means less error
handling code that we can break which is nice.  There's probably a case
for an improved OF helper here...

--5+z6kX2Nyw2GkWv9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSX++4AAoJELSic+t+oim9UWQP/0NLFy/f672CK3D2TKw6jpXp
t+kX7AU+gXDdmR82JsW1LpMa+ZZtgA/RYezIi+yKL0BOadXLEdIZB86wsRT+Sqsp
luBmPkpdVMCJDjcUpcatCsTkPBlqNy6UstzY+RnJlLUJ9QqC2JmUrueouZEcQXDj
MKj13kFv+hp/6WTxBiaaVJdVhQ4S4ky2rYR4xtIQe0Fd/QGFYgEuRaOvwZx1+txY
oennu3y9ADupCEcB3qzsnYj0EWu+wEbBltAMNa+lzHyc6pz1CqBrpKZguM9/Hj7t
NManCo9b/3GA9ZQAasg2/lMwchqeMHswtg6N1aL9DDgpr58TWh75mBdiFqPtISjI
k+ynBTwKfbEJtEF1xFEOfD9bHLZpmmqAQ9VSqg3gYzALCUqusqpdGbgPMM/edH5q
Et14WDYSH/BZSuXUoJeQ53QjlqNFdWXAF51Vf3f1RoSkWoT53QCn2TEsc2oH5wUF
GogKb67uxz+J4Rqe75aWpq5KRj5szkY0XmvOuwU4Po8RceJp0RuhSpqcGldlm2jn
1wv/RVwiZeiPi74vTAaTUqqOMW6BXWmTktHVYVdzDZeVd5tgoqJ16tiQQB3XBQrl
1qrJLxM6h/6/BDyR7NqpkPB3UvIwYDwbyISmgsEDVgw4W3FznpsLbbBiJdbsBXBz
u30E/rYr0FH2eMVLlGk7
=Bz6j
-----END PGP SIGNATURE-----

--5+z6kX2Nyw2GkWv9--
