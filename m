Return-Path: <michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 8/11] powerpc: Add strne2a() to convert a string from
	EBCDIC to ASCII
Date: Wed, 22 Mar 2006 10:25:40 +1100
References: <1142934351.193140.181086235013.qpush@concordia>
	<je64m7sl6g.fsf@sykes.suse.de>
	<20060321184358.GB5248@pb15.lixom.net>
In-Reply-To: <20060321184358.GB5248@pb15.lixom.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1716182.njdcWcKOR6";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200603221025.48798.michael@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart1716182.njdcWcKOR6
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wed, 22 Mar 2006 05:43, Olof Johansson wrote:
> On Tue, Mar 21, 2006 at 07:32:39PM +0100, Andreas Schwab wrote:
> > Olof Johansson <olof@lixom.net> writes:
> > > Why iterate over the string twice? Why not do
> > > 	for (..; i < n && src[n]; ...)
> >
> > ITYM i < n && src[i].
>
> Doh, right.

That's why :)

=2D-=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--nextPart1716182.njdcWcKOR6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEIIt8dSjSd0sB4dIRAldNAJ42LB1X5irBoTzXUWp8PzX3fxBIfgCgyLEv
6un/lv69sce/hDfnj0/+bKI=
=9Tyf
-----END PGP SIGNATURE-----

--nextPart1716182.njdcWcKOR6--
