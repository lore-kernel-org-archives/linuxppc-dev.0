Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (unknown [IPv6:2001:41c8:1:5384::2])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D9E1B2C00BA
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Oct 2013 04:32:19 +1100 (EST)
Date: Fri, 18 Oct 2013 18:31:26 +0100
From: Mark Brown <broonie@kernel.org>
To: Xiubo Li <Li.Xiubo@freescale.com>
Message-ID: <20131018173126.GU2443@sirena.org.uk>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
 <1382000477-17304-9-git-send-email-Li.Xiubo@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="9xrpoCjP1Nd9xumY"
In-Reply-To: <1382000477-17304-9-git-send-email-Li.Xiubo@freescale.com>
Subject: Re: [PATCHv1 8/8] Documentation: Add device tree bindings for
 Freescale VF610 sound.
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org,
 linux-doc@vger.kernel.org, tiwai@suse.de, b18965@freescale.com, timur@tabi.org,
 perex@perex.cz, r65073@freescale.com, LW@KARO-electronics.de,
 linux@arm.linux.org.uk, b42378@freescale.com,
 linux-arm-kernel@lists.infradead.org, grant.likely@linaro.org,
 devicetree@vger.kernel.org, ian.campbell@citrix.com, pawel.moll@arm.com,
 swarren@wwwdotorg.org, rob.herring@calxeda.com, oskar@scara.com,
 fabio.estevam@freescale.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
 rob@landley.net, r64188@freescale.com, shawn.guo@linaro.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--9xrpoCjP1Nd9xumY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 17, 2013 at 05:01:17PM +0800, Xiubo Li wrote:

> +  -- Power supplies:
> +     * Mic Bias
> +
> +  -- SGTL5000 pins:
> +     * MIC_IN
> +     * LINE_IN
> +     * HP_OUT
> +     * LINE_OUT

Things that are part of the CODEC should be part of the CODEC binding
and this binding should reference that - this way the information
doesn't have to be replicated by all boards using the CODEC and if new
devices are supported by the CODEC driver then only that needs updating
hopefully.

--9xrpoCjP1Nd9xumY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSYXBqAAoJELSic+t+oim9bgEP/RmwhwxlWyJMLunN/vXk/RpG
0R1ttv9mJYHnc6oPFUgtpQIYy1hobgLuHz5XGyHsALBoFr7x6uDQcfo0VOZN+jcD
WzP4FqmE/B8oWKq4qttFaS9rqN+htmHkXX/sXn4eVdf+TjjewEW6hMXBk7E0brDw
7Wfj5qaqQdDq7vFM7khvkJFyNK4/oJMugOfVoulaxcDt/amzUbYnqr8+Qr7BMNK9
58gk1CpFqU23iPdPlvvyjw/YPcO0RnzuHSUKMIop5xLrF1jrtsbr8Ds0dHtRcQvr
D81QYWT8GJAVosCMVHNAs4Ri4luwNxFzkTTq0dDKmiFrogEoy6YZ798VXGl91hLI
G6eV07hx2eo5P5F6cJ087kHNBF0EE7XFImeh40E4xbmn3RXBChc4PBqc21gH8uLI
U6xeFJPT5Fkca6GzAjfP/e9P+40Z6icCyW6oXpzgPQKr49rmCrc/aQ1g068baA1o
xhLGhg2FMGREj7JiJSgfUJP7doaQjwAEV67Q9JM8X0jtcUsWoo9X5f2asPHSh8Ok
5Xm4wSc4v0TcCAy2CJKBmS0RUxxJ10xKyqyUo/p1cDcEKGzYH8lcjx0DHGjAD7+I
DBaitO9mMeUutJaYZikH5cAS7qvri3e8+H4xeE5hyYddys9Kz01IqjvsdkbTwnjb
bP8WKJg9Q8LQCTw40kSv
=QO4U
-----END PGP SIGNATURE-----

--9xrpoCjP1Nd9xumY--
