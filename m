Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id DB399DDE0C
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 11:55:02 +1000 (EST)
Date: Tue, 29 Apr 2008 11:54:56 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Remi Machet <rmachet@slac.stanford.edu>
Subject: Re: [PATCH] sysdev,mv64x60: MV64x60 device bus
Message-Id: <20080429115456.2fa164c7.sfr@canb.auug.org.au>
In-Reply-To: <1209402729.14407.2.camel@pcds-ts102.slac.stanford.edu>
References: <1209402729.14407.2.camel@pcds-ts102.slac.stanford.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__29_Apr_2008_11_54_56_+1000_Vgi75Jws1H=VAtF/"
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__29_Apr_2008_11_54_56_+1000_Vgi75Jws1H=VAtF/
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Remi,

On Mon, 28 Apr 2008 10:12:09 -0700 Remi Machet <rmachet@slac.stanford.edu> =
wrote:
>
> +static struct of_device_id of_mv64x60_devices[] =3D {

__initdata, please.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__29_Apr_2008_11_54_56_+1000_Vgi75Jws1H=VAtF/
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIFn/0TgG2atn1QN8RAirGAJwParzN1/T40RljzS+2FpNRQuxhIQCffnwX
eVQqGWibMdG+V1M0THoN23c=
=TT1t
-----END PGP SIGNATURE-----

--Signature=_Tue__29_Apr_2008_11_54_56_+1000_Vgi75Jws1H=VAtF/--
