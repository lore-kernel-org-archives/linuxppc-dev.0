Return-Path: <michael@ellerman.id.au>
Subject: Re: [POWERPC] merge iSeries i/o operations with the rest
From: Michael Ellerman <michael@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20060921100315.89d74f6f.sfr@canb.auug.org.au>
References: <20060905120817.e52857ee.sfr@canb.auug.org.au>
	<20060918153853.f4332d2a.sfr@canb.auug.org.au>
	<20060920221558.1322b8b4.sfr@canb.auug.org.au>
	<1158768096.19375.6.camel@basalt.austin.ibm.com>
	<20060921100315.89d74f6f.sfr@canb.auug.org.au>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-y8zCUYgLA1WihWQ52Koy"
Date: Thu, 21 Sep 2006 10:20:41 +1000
Message-Id: <1158798041.7062.4.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org,
	Hollis Blanchard <hollisb@us.ibm.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-y8zCUYgLA1WihWQ52Koy
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-09-21 at 10:03 +1000, Stephen Rothwell wrote:
> Hi Hollis,
>=20
> On Wed, 20 Sep 2006 11:01:36 -0500 Hollis Blanchard <hollisb@us.ibm.com> =
wrote:
> >
> > On Wed, 2006-09-20 at 22:15 +1000, Stephen Rothwell wrote:
> > > +       if (firmware_has_feature(FW_FEATURE_ISERIES)) {
> > > +               BUG();
> > > +               return;
> > > +       }
> >=20
> > Shouldn't all these be BUG_ON(firmware_has_feature(FW_FEATURE_ISERIES))=
?
>=20
> In this case, the return helps because the compiler will not generate the
> following code in iSeries only builds.  If we could tell the compiler
> that BUG() and BUG_ON() won't return, then BUG_ON() would be better.

Just put a return in the BUG_ON() macro ;D

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-y8zCUYgLA1WihWQ52Koy
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBFEdrZdSjSd0sB4dIRAjeCAJ4jiuxuy14+RK/hIMSD+vMe0ESJhQCfWjdD
fjQBOiojTaFfEvdgF+EqNog=
=lSoI
-----END PGP SIGNATURE-----

--=-y8zCUYgLA1WihWQ52Koy--
