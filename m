Return-Path: <michael@ellerman.id.au>
Subject: Re: [RFC/PATCH 8/9] Make 64-bit cpu features defined on 32-bit
From: Michael Ellerman <michael@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20061116211759.003f3dbd.sfr@canb.auug.org.au>
References: <1163661800.406227.631357998554.qpush@cradle>
	<20061116072329.12C5067BEA@ozlabs.org>
	<20061116211759.003f3dbd.sfr@canb.auug.org.au>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-sKF/2103VzaxgO2qU97D"
Date: Fri, 17 Nov 2006 10:03:45 +1100
Message-Id: <1163718226.16815.11.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Arnd Bergmann <arnd.bergmann@de.ibm.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-sKF/2103VzaxgO2qU97D
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-11-16 at 21:17 +1100, Stephen Rothwell wrote:
> On Thu, 16 Nov 2006 18:23:27 +1100 Michael Ellerman <michael@ellerman.id.=
au> wrote:
> >
> > It saves #ifdef'ing in callers if we at least define the 64-bit cpu
> > features for 32-bit also.
>=20
> Does it matter that some of the 64 bit feature bit defines are 0 on 32
> bit?

Not for me, I just want to be able to call cpu_has_feature() on it. If
the feature is 0 it'll always return false.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-sKF/2103VzaxgO2qU97D
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFXO5RdSjSd0sB4dIRArWZAKCqNZT8a4Y3LRiMhwiOvSXyQfHeeQCfUHEr
q5WkYOuhm+4nu9b+aRhu2Ww=
=SRpj
-----END PGP SIGNATURE-----

--=-sKF/2103VzaxgO2qU97D--
