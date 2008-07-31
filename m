Return-Path: <michael@ellerman.id.au>
Subject: Re: [Bugme-new] [Bug 11185] New: Device/host RESET in SCSI
From: Michael Ellerman <michael@ellerman.id.au>
To: Matthew Wilcox <matthew@wil.cx>
In-Reply-To: <20080731072159.GB30534@parisc-linux.org>
References: <bug-11185-10286@http.bugzilla.kernel.org/>
	<20080730232409.81965504.akpm@linux-foundation.org>
	<20080731072159.GB30534@parisc-linux.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-gbcjLm/evgTzEQPTNu4Q"
Date: Thu, 31 Jul 2008 17:32:42 +1000
Message-Id: <1217489562.1487.55.camel@localhost>
Mime-Version: 1.0
Cc: cijoml@volny.cz, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>,
	bugme-daemon@bugzilla.kernel.org, linux-scsi@vger.kernel.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-gbcjLm/evgTzEQPTNu4Q
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2008-07-31 at 01:21 -0600, Matthew Wilcox wrote:
> On Wed, Jul 30, 2008 at 11:24:09PM -0700, Andrew Morton wrote:
> > Why do you describe this regression as a powerpc problem rather than a
> > scsi one?
> >=20
> > (It could be either or both, I'm just wondering...)
>=20
> This seems quite astute of the reporter.  The error messages from sym2
> are consistent with an interrupt routing problem.=20

Hmm I suppose.

In that case can we see the full dmesg and a tarball
of /proc/device-tree from a working kernel, Cijoml?

Which begs the question what was the latest working kernel version?

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-gbcjLm/evgTzEQPTNu4Q
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIkWqadSjSd0sB4dIRAlDeAJ9WZI6+Q+2zeJG1Fha2oVipE7AsnACdEEdr
kLrMnjJSWDOklwQvoMraVbU=
=5iws
-----END PGP SIGNATURE-----

--=-gbcjLm/evgTzEQPTNu4Q--
