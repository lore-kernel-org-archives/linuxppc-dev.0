Return-Path: <michael@ellerman.id.au>
Subject: Re: [patch 03/18] PS3: Use __maybe_unused
From: Michael Ellerman <michael@ellerman.id.au>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <46662315.30004@am.sony.com>
References: <20070606024407.786638029@am.sony.com> >
	<46662315.30004@am.sony.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-II85jDKHvoGTOJs+pdi1"
Date: Wed, 06 Jun 2007 14:05:45 +1000
Message-Id: <1181102745.5536.18.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-II85jDKHvoGTOJs+pdi1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-06-05 at 19:59 -0700, Geoff Levand wrote:
> Change the PS3 debug routines from using the GCC specific
> '__attribute__ ((unused))' to the preprocessor macro
> __maybe_unused.

I'm confused. If DEBUG is defined then they're used, if it's not then
they're not built.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-II85jDKHvoGTOJs+pdi1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGZjKZdSjSd0sB4dIRAiGIAJ9xzDYqhMjnCvfGlKV6vt0gYJf0YACffSro
B+LFQPhpgYPtToKXfg2yaFY=
=OwIq
-----END PGP SIGNATURE-----

--=-II85jDKHvoGTOJs+pdi1--
