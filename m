Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 633D5DDFCA
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 17:30:09 +1100 (EST)
Date: Fri, 11 Jan 2008 17:29:57 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Gibson <dwg@au1.ibm.com>
Subject: Re: Enable RTC for Ebony and Walnut (v2)
Message-Id: <20080111172957.c0431145.sfr@canb.auug.org.au>
In-Reply-To: <20080111032534.GA25055@localhost.localdomain>
References: <20071221022130.GI2665@localhost.localdomain>
	<20080111032534.GA25055@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__11_Jan_2008_17_29_57_+1100_mH6jwLIZNu_dS=c5"
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__11_Jan_2008_17_29_57_+1100_mH6jwLIZNu_dS=c5
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 11 Jan 2008 14:25:34 +1100 David Gibson <dwg@au1.ibm.com> wrote:
>
> +++ working-2.6/arch/powerpc/sysdev/of_rtc.c	2008-01-11 14:17:03.00000000=
0 +1100

> +static __initdata struct {
> +	const char *compatible;

If you make this an array, then the string will become __initdata as well.

> +	char *plat_name;
> +} of_rtc_table[] =3D {
> +	{ "ds1743-nvram", "rtc-ds1742" },
> +};

> +			platform_device_register_simple(plat_name, -1, res, 1);

Do we care if this fails?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__11_Jan_2008_17_29_57_+1100_mH6jwLIZNu_dS=c5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHhwzpTgG2atn1QN8RAkMeAKCZQgSNGHaNMj9lpI0Yzt3FY1WsPgCfYxvM
FJ8vYsqjeLHFvz1+bzfeqtM=
=c731
-----END PGP SIGNATURE-----

--Signature=_Fri__11_Jan_2008_17_29_57_+1100_mH6jwLIZNu_dS=c5--
