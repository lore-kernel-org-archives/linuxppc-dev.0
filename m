Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id A8AC1DDE1A
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Mar 2008 16:39:45 +1100 (EST)
Date: Sun, 23 Mar 2008 16:38:29 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] windfarm: add PowerMac 12,1 support
Message-Id: <20080323163829.dff24423.sfr@canb.auug.org.au>
In-Reply-To: <1206228673.9540.115.camel@pmac.infradead.org>
References: <1201348525.6859.1.camel@thilivren>
	<1206214508.9540.89.camel@pmac.infradead.org>
	<1206223998.7197.13.camel@pasglop>
	<1206226966.9540.104.camel@pmac.infradead.org>
	<20080323102502.e0754062.sfr@canb.auug.org.au>
	<1206228673.9540.115.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sun__23_Mar_2008_16_38_29_+1100_/UwGeFC4yKBU845K"
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

--Signature=_Sun__23_Mar_2008_16_38_29_+1100_/UwGeFC4yKBU845K
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dave,

On Sat, 22 Mar 2008 23:31:13 +0000 David Woodhouse <dwmw2@infradead.org> wr=
ote:
>
> On Sun, 2008-03-23 at 10:25 +1100, Stephen Rothwell wrote:
> > Why would you expect otherwise (from the C standard):
> >=20
> > "Unlike the bitwise binary & operator, the && operator guarantees
> > left-to-right evaluation; there is a sequence point after the evaluation
> > of the first operand. If the first operand compares equal to 0, the
> > second operand is not evaluated."
>=20
> Because it's Saturday night

That seems like all the explanation necessary :-)

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sun__23_Mar_2008_16_38_29_+1100_/UwGeFC4yKBU845K
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH5ezaTgG2atn1QN8RArDFAJoDOx3rae0OrbSPjfMdh+xhDgVMKQCfS+92
wOrHv6CbWRUPwDiw7CmYz2U=
=pZXS
-----END PGP SIGNATURE-----

--Signature=_Sun__23_Mar_2008_16_38_29_+1100_/UwGeFC4yKBU845K--
