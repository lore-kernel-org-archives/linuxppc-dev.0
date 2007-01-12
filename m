Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 4/7] MPIC MSI allocator
From: Michael Ellerman <michael@ellerman.id.au>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20070112002712.GA15117@lixom.net>
References: <1168514716.63474.857278133999.qpush@cradle>
	<20070111112504.37999DDF3E@ozlabs.org>
	<20070112002712.GA15117@lixom.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-uYk1qTasWQrEB879d3S0"
Date: Fri, 12 Jan 2007 11:33:46 +1100
Message-Id: <1168562026.4647.8.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: Greg Kroah-Hartman <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-uYk1qTasWQrEB879d3S0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-01-11 at 18:27 -0600, Olof Johansson wrote:
> On Thu, Jan 11, 2007 at 10:25:21PM +1100, Michael Ellerman wrote:
> > To support MSI on MPIC we need a way to reserve and allocate hardware i=
rq
> > numbers, this patch implements an allocator for that.
> >=20
> > Updated to only do dogy-U3-fallback-hacks on U3, all other platforms mu=
st
> > define a "msi-ranges" property on their MPIC node for MSI to work.
>=20
> The msi-ranges spec isn't documented anywhere besides the code where it's
> used. Please add it to Documentation/powerpc/booting-without-of.txt too.

OK, will do.

I'm going to rename it to "msi-available-ranges" while I'm at it, PAPR
defines an "ibm,msi-ranges" property which has a very different meaning,
so I think the longer name is less confusing - even if there's never
going to be any machine with both.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-uYk1qTasWQrEB879d3S0
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFptdqdSjSd0sB4dIRAoCTAJ9iSZKOu0Gty45JB2DNJhqP7K+MPACgm4du
x4D3j6MDffGl05QjCAeo7c4=
=sbkf
-----END PGP SIGNATURE-----

--=-uYk1qTasWQrEB879d3S0--
