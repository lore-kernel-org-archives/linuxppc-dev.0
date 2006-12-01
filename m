Return-Path: <michael@ellerman.id.au>
Subject: Re: [POWERPC] Allow xmon to build on legacy iSeries
From: Michael Ellerman <michael@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20061130160459.4f617199.sfr@canb.auug.org.au>
References: <20061130114409.994a661e.sfr@canb.auug.org.au>
	<1164848648.27764.2.camel@concordia.ozlabs.ibm.com>
	<20061130160459.4f617199.sfr@canb.auug.org.au>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-hcgFEl+fIi2ii6DZl50/"
Date: Fri, 01 Dec 2006 11:04:34 +1100
Message-Id: <1164931474.5348.3.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-hcgFEl+fIi2ii6DZl50/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-11-30 at 16:04 +1100, Stephen Rothwell wrote:
> On Thu, 30 Nov 2006 12:04:08 +1100 Michael Ellerman <michael@ellerman.id.=
au> wrote:
> >
> > Why the ifdefs around the firmware check? Shouldn't it compile out to
> > nothing for !ISERIES anyway?
>=20
> I wasn't sure if it gets built for 32 bit or ppc and have broken them
> before.  This was the patch is very obviously safe and is more likely to
> get accepted ...

The safe road ey :)

It does get built for 32-bit, but the firmware feature test is safe.
AFAIK ppc still has its own copy of xmon which it uses.

ps. why are you including <asm/iseries/it_lp_reg_save.h> instead of
firmware.h?

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-hcgFEl+fIi2ii6DZl50/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFb3GRdSjSd0sB4dIRAmHgAKCw1Kt6H9TWcLpY/y4fS+1i5gCPJACdFQz2
S1jFW4p4ySlqwy/y99T/E1M=
=qRyH
-----END PGP SIGNATURE-----

--=-hcgFEl+fIi2ii6DZl50/--
