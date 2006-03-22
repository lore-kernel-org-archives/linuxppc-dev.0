Return-Path: <michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 4/11] powerpc: Replace platform_is_lpar() with a firmware
	feature
Date: Wed, 22 Mar 2006 11:48:08 +1100
References: <1142934351.193140.181086235013.qpush@concordia>
	<20060321094630.E7AD067B21@ozlabs.org>
	<20060322113508.08b07cb4.sfr@canb.auug.org.au>
In-Reply-To: <20060322113508.08b07cb4.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12162016.lT6WeYzz8T";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200603221148.12849.michael@ellerman.id.au>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, paulus@samba.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart12162016.lT6WeYzz8T
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wed, 22 Mar 2006 11:35, Stephen Rothwell wrote:
> On Tue, 21 Mar 2006 20:45:59 +1100 Michael Ellerman <michael@ellerman.id.=
au>=20
wrote:
> > It has been decreed that platform numbers are evil, so as a step in that
> > direction, replace platform_is_lpar() with a FW_FEATURE_LPAR bit.
> >
> > Currently FW_FEATURE_LPAR really means i/pSeries LPAR, in the future we
> > might have to clean that up if we need to be more specific about what
> > LPAR actually means. But that's another patch ...
> >
> > Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
>
> Just wondering if you considered just #defining platform_is_lpar() to be
> firmware_has_feature(FW_FEATURE_LPAR) ...

Thought about it, but decided it was ugly, and obscures what's really=20
happening, ie. LPAR-ness is just a FW_FEATURE bit.

cheers

=2D-=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--nextPart12162016.lT6WeYzz8T
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEIJ7MdSjSd0sB4dIRAgZoAKCeQgCqM0G+x4+V0mqq8nx3KMGEpACdETLC
5p6hdwLBMI3XtiROrje/Dcc=
=ryHs
-----END PGP SIGNATURE-----

--nextPart12162016.lT6WeYzz8T--
