Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 97BC7DE03C
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 10:41:08 +1100 (EST)
Date: Thu, 10 Jan 2008 10:40:48 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 2/3] [libata] pata_of_platform: OF-Platform PATA device
	driver
Message-Id: <20080110104048.2fea6ab3.sfr@canb.auug.org.au>
In-Reply-To: <20080109191041.GB23283@localhost.localdomain>
References: <20080109190852.GA18827@localhost.localdomain>
	<20080109191041.GB23283@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__10_Jan_2008_10_40_48_+1100_aNdF._OFk=L5Qh94"
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	Paul Mundt <lethal@linux-sh.org>, Jeff Garzik <jeff@garzik.org>,
	linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__10_Jan_2008_10_40_48_+1100_aNdF._OFk=L5Qh94
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Anton,

Juts one small trivial comment (could be fixed later).

On Wed, 9 Jan 2008 22:10:41 +0300 Anton Vorontsov <avorontsov@ru.mvista.com=
> wrote:
>
> +static struct of_device_id pata_of_platform_match[] =3D {

This could be declared const.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__10_Jan_2008_10_40_48_+1100_aNdF._OFk=L5Qh94
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHhVuJTgG2atn1QN8RAlr7AJsEN75lL0OqFKaqj7Yqva3k6sv8GgCffw/V
bSReSUpNRukeVOgeRxbLK3s=
=2Ex6
-----END PGP SIGNATURE-----

--Signature=_Thu__10_Jan_2008_10_40_48_+1100_aNdF._OFk=L5Qh94--
