Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 45FD8DDFCF
	for <linuxppc-dev@ozlabs.org>; Wed, 13 May 2009 19:13:40 +1000 (EST)
Date: Wed, 13 May 2009 11:13:30 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Trent Piepho <xyzzy@speakeasy.org>
Subject: Re: [PATCH] leds: Add options to have GPIO LEDs start on or keep
	their state
Message-ID: <20090513091330.GA3078@pengutronix.de>
References: <fa686aa40904172207sc0f923eoefe8fb0a2703d548@mail.gmail.com>
	<1242167592-14649-1-git-send-email-xyzzy@speakeasy.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
In-Reply-To: <1242167592-14649-1-git-send-email-xyzzy@speakeasy.org>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Richard Purdie <rpurdie@rpsys.net>,
	Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Trent,

> diff --git a/include/linux/leds.h b/include/linux/leds.h
> index 376fe07..66e7d75 100644
> --- a/include/linux/leds.h
> +++ b/include/linux/leds.h
> @@ -141,9 +141,14 @@ struct gpio_led {
>  	const char *name;
>  	const char *default_trigger;
>  	unsigned 	gpio;
> -	u8 		active_low : 1;
> -	u8		retain_state_suspended : 1;
> +	unsigned	active_low : 1;
> +	unsigned	retain_state_suspended : 1;
> +	unsigned	default_state : 2;
> +	/* default_state should be one of LEDS_GPIO_DEFSTATE_(ON|OFF|KEEP) */

Any specific reason for the change from u8 to unsigned? Could be
mentioned in the patch description maybe. And what Sean mentioned :)

Other than that:

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkoKjzoACgkQD27XaX1/VRs9UgCgmo2nP69Og40eX/x736TPEAEd
uX0An1bx1SkGnS5xL53JI8RmG2+t9/Eq
=Dtjw
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
