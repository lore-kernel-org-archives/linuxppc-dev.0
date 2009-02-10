Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc/cell: fix dependency in cpufreq
From: Michael Ellerman <michael@ellerman.id.au>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <18282.1234226812@neuling.org>
References: <18282.1234226812@neuling.org>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-XJK1xuHoLeVZJgAT0VZt"
Date: Tue, 10 Feb 2009 12:01:32 +1100
Message-Id: <1234227692.8149.58.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-XJK1xuHoLeVZJgAT0VZt
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2009-02-10 at 11:46 +1100, Michael Neuling wrote:
> cbe_cpufreq.c uses cbe_cpufreq_has_pmi which is provided by
> cbe_cpufreq_pmi.c.  Hence CBE_CPUFREQ depends on CBE_CPUFREQ_PMI.
>=20
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---
> I'm not 100% sure is this the right fix.  Should CBE_CPUFREQ really
> depend on CBE_CPUFREQ_PMI?

No I don't think it is. Look at platforms/cell/cbe_cpufreq.h, the
intention seems to be that if PMI isn't built in then that variable is
hardcoded to 0 and we never use the pmi routines.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-XJK1xuHoLeVZJgAT0VZt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkmQ0ewACgkQdSjSd0sB4dIwVQCgl+QPrB/Csx6L90V2Ipg/RbIC
w1UAn2ZKrxGiK/9F2X5sK+JFfMuXM16m
=tfIz
-----END PGP SIGNATURE-----

--=-XJK1xuHoLeVZJgAT0VZt--
