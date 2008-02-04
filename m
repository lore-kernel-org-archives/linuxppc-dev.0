Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 91B61DDE0A
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Feb 2008 17:39:58 +1100 (EST)
Date: Mon, 4 Feb 2008 17:39:52 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: [PATCH] create modalias file in sysfs for bus vio
Message-Id: <20080204173952.8afa9129.sfr@canb.auug.org.au>
In-Reply-To: <20080125170914.GA29887@aepfle.de>
References: <20080122083328.GA11928@aepfle.de>
	<20080123010505.d812129e.sfr@canb.auug.org.au>
	<20080125170914.GA29887@aepfle.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__4_Feb_2008_17_39_52_+1100_iNO8GSQg6zlX/KrS"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Mon__4_Feb_2008_17_39_52_+1100_iNO8GSQg6zlX/KrS
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Olaf,

[Sorry, been on vacation]

On Fri, 25 Jan 2008 18:09:14 +0100 Olaf Hering <olaf@aepfle.de> wrote:
>
> On Wed, Jan 23, Stephen Rothwell wrote:
>=20
> > It would be nice if we could factor out the "vio:T%sS%s" string as it is
> > also used in vio_hotplug().
>=20
> What exactly do you have in mind?
> Creating a tempstring seems to make things more complicated.

Yeah, but it would be nice if the format only had to be known/changed in
one place.  Don't worry about it for now. Or maybe create a "static const
char []" or #define with the string.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__4_Feb_2008_17_39_52_+1100_iNO8GSQg6zlX/KrS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHprM9TgG2atn1QN8RAhNGAKCaQZYKve3IrPCGChnLJMoBgh7PYQCaApkn
hS2J6j4lKrgD5BjKCTVvsvE=
=wy+T
-----END PGP SIGNATURE-----

--Signature=_Mon__4_Feb_2008_17_39_52_+1100_iNO8GSQg6zlX/KrS--
