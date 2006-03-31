Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] PowerMac11,2 i2c-bus@0 duplicate dev-tree workaround
From: Michael Ellerman <michael@ellerman.id.au>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1143758297.5388.12.camel@localhost>
References: <1143631816.9481.5.camel@localhost>
	<1143700119.23392.27.camel@localhost.localdomain>
	<1143758297.5388.12.camel@localhost>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-xhBNBoRv5joa+y6Ve8+n"
Date: Fri, 31 Mar 2006 16:37:23 +1100
Message-Id: <1143783444.28005.10.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-xhBNBoRv5joa+y6Ve8+n
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-03-31 at 00:38 +0200, Johannes Berg wrote:
> On Thu, 2006-03-30 at 17:28 +1100, Michael Ellerman wrote:
>=20
> > I don't understand why we need this patch? If we care about getting the
> > "right" node why not check for that where we care?
>=20
> It's not just a single node but also contains sub-nodes. In one of them,
> one of those sub nodes is there but contains bogus info, and in the
> other both are there and contain the right info. Some things that work
> off these bus nodes are detected twice if they're there, and they're
> used in at least two places that I know of.

OK, that sounds a little complicated. I'm just worried about having lots
workarounds in the unflattening code, the code's hard enough to read as
it is. I think it's preferable to do the workarounds in the code that
needs the workaround, that way they're isolated in certain parts of the
code rather than all in the unflattening.

cheers

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person
--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-xhBNBoRv5joa+y6Ve8+n
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBELMATdSjSd0sB4dIRAoC3AJ4h8L5CF/YnTPRK8dUR7jMQWEbj0gCfRxLw
IQfwLhCELbOffUVrc+jring=
=tCaf
-----END PGP SIGNATURE-----

--=-xhBNBoRv5joa+y6Ve8+n--
