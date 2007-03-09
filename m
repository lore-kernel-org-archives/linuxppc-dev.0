Return-Path: <jbglaw@lug-owl.de>
Received: from lug-owl.de (lug-owl.de [195.71.106.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 07E00DDEB8
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Mar 2007 06:35:28 +1100 (EST)
Date: Fri, 9 Mar 2007 20:35:24 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH] Complain about missing system calls.
Message-ID: <20070309193524.GX18564@lug-owl.de>
References: <1173394873.3461.510.camel@pmac.infradead.org>
	<p737itqbdnl.fsf@bingen.suse.de>
	<20070309163805.GV18564@lug-owl.de>
	<20070309190051.GA20521@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1RhGCd1AsoFHGRHc"
In-Reply-To: <20070309190051.GA20521@one.firstfloor.org>
Cc: akpm@osdl.org, linux-arch@vger.kernel.org, sam@ravnborg.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	David Woodhouse <dwmw2@infradead.org>, rmk@arm.linux.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--1RhGCd1AsoFHGRHc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-03-09 20:00:51 +0100, Andi Kleen <andi@firstfloor.org> wrote:
> > Not everybody has a simple indexed list of pointers :)  For example,
> > for vax-linux, we use a struct per syscall with the expected number of
> > on-stack longwords for the call.
> >=20
> > So if something "new" is coming up, please keep in mind that it should
> > be flexible enough to represent that. :)
>=20
> Are there plans to merge vax any time soon to mainline?=20

Well...  That depends :)  For now, I'd prefer to stay out of mainline,
until we're having gcc-trunk with a current GNU libc up'n'running.
Until then, I plan to at least break the complete ABI once (drop old
syscals and _only_ wire up their modern counterparts.)

> Normally we don't care very much about out of tree code, especially
> if it adds complexity like this.

Sure, but at least mentioning that there's more than only a simple
table of function pointers may or may not help to *plan* the code to
fit future needs.

> But I suspect s390 would need number of arguments anyways.

Any they're already merged. Yay :)

MfG, JBG

--=20
      Jan-Benedict Glaw      jbglaw@lug-owl.de              +49-172-7608481
  Signature of:                           Wenn ich wach bin, tr=C3=A4ume ic=
h.
  the second  :

--1RhGCd1AsoFHGRHc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFF8bb8Hb1edYOZ4bsRAudgAJ0e9E00kfFWDmaVhFGsYPn40r4GzgCeOjeF
Tlc1fPEqvles7f9IUqYRw4o=
=2Dxi
-----END PGP SIGNATURE-----

--1RhGCd1AsoFHGRHc--
