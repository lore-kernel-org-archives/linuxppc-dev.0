Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 4DECDDDFE0
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Mar 2008 10:26:26 +1100 (EST)
Date: Sun, 23 Mar 2008 10:25:02 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] windfarm: add PowerMac 12,1 support
Message-Id: <20080323102502.e0754062.sfr@canb.auug.org.au>
In-Reply-To: <1206226966.9540.104.camel@pmac.infradead.org>
References: <1201348525.6859.1.camel@thilivren>
	<1206214508.9540.89.camel@pmac.infradead.org>
	<1206223998.7197.13.camel@pasglop>
	<1206226966.9540.104.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sun__23_Mar_2008_10_25_02_+1100_cev/9dYz4zBhmiPx"
Cc: =?UTF-8?B?w4l0aWVubmU=?= Bersac <bersace03@gmail.com>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sun__23_Mar_2008_10_25_02_+1100_cev/9dYz4zBhmiPx
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 22 Mar 2008 23:02:46 +0000 David Woodhouse <dwmw2@infradead.org> wr=
ote:
>
> Yeah, there's weird shit going on with the sensor/control registration.
> I think GCC is be miscompiling it -- the sequence of
> 	all =3D all && pm121_register_control(foo...);
> 	all =3D all && pm121_register_control(bar...);
> is bailing out as soon as 'all' gets set to zero. Despite the fact that
> pm121_register_control() quite blatantly has side-effects.

Why would you expect otherwise (from the C standard):

"Unlike the bitwise binary & operator, the && operator guarantees
left-to-right evaluation; there is a sequence point after the evaluation
of the first operand. If the first operand compares equal to 0, the
second operand is not evaluated."

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sun__23_Mar_2008_10_25_02_+1100_cev/9dYz4zBhmiPx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD4DBQFH5ZVhTgG2atn1QN8RAhVcAJ93q28Kmb5f/gKisizsbMCapyHgEgCYgydn
eHYI2E/Ux3FBuAS69A3AdQ==
=g0bl
-----END PGP SIGNATURE-----

--Signature=_Sun__23_Mar_2008_10_25_02_+1100_cev/9dYz4zBhmiPx--
