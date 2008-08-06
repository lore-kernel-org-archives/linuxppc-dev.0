Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 0D616DDFB3
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Aug 2008 00:10:15 +1000 (EST)
Date: Thu, 7 Aug 2008 00:10:06 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH]: Remove bogons from the iSeries console
Message-Id: <20080807001006.37a9fc4f.sfr@canb.auug.org.au>
In-Reply-To: <20080806140629.268fcf07@lxorguk.ukuu.org.uk>
References: <20080806140629.268fcf07@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__7_Aug_2008_00_10_06_+1000_TUCbgU3YDjZubQKp"
Cc: boutcher@us.ibm.com, linuxppc-dev@ozlabs.org, torvalds@osdl.org,
	devilbis@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__7_Aug_2008_00_10_06_+1000_TUCbgU3YDjZubQKp
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Alan,

On Wed, 6 Aug 2008 14:06:29 +0100 Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
> The iSeries driver calls into the n_tty ldisc code directly for some
> bizarre reason. I previously tagged this with a query but this actually
> does need fixing as n_tty methods when you have a different ldisc set are
> not a good thing to call.
>=20
> In n_tty mode this change should have no effect, the core tty layer has
> always called the ldisc ioctl method *anyway* and will call the one for
> the right ldisc.
>=20
> Signed-off-by: Alan Cox <alan@redhat.com>

I will take your word for it as I have no idea.  This driver needs to be
deprecated anyway (in favour of hcv_iseries).

You may consider this
Acked-by: Stephen Rothwell <sfr@canb.auug.org.au>
as defacto iSeries maintainer.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__7_Aug_2008_00_10_06_+1000_TUCbgU3YDjZubQKp
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiZsL4ACgkQjjKRsyhoI8z1sgCeLikhF/ur6iR8v4YWHZ5jtlCk
e6AAn1Kp/vjUi9ga7nghA7QU4nrnOXjB
=RYP2
-----END PGP SIGNATURE-----

--Signature=_Thu__7_Aug_2008_00_10_06_+1000_TUCbgU3YDjZubQKp--
