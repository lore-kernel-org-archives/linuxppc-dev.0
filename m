Return-Path: <devurandom@gmx.net>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by ozlabs.org (Postfix) with ESMTP id 24C682C0174
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 21:52:09 +1000 (EST)
Received: from mailout-de.gmx.net ([10.1.76.24]) by mrigmx.server.lan
 (mrigmx002) with ESMTP (Nemesis) id 0LqXa3-1Uzneg2JUH-00e1Vg for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 13:52:07 +0200
Date: Tue, 23 Apr 2013 13:51:55 +0200
From: Dennis Schridde <devurandom@gmx.net>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: PROBLEM: Only 2 of 4 cores used on IBM Cell blades and no
 threads shown in spufs
Message-ID: <20130423135155.7b307094@samson>
In-Reply-To: <20130423091246.GA18195@concordia>
References: <1470334.YUWOQ37ijW@ernie>
	<20130423091246.GA18195@concordia>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/y6JmPSpUPSXBINraK69qLHV"; protocol="application/pgp-signature"
Cc: cbe-oss-dev@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/y6JmPSpUPSXBINraK69qLHV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hello Michael!

Am Tue, 23 Apr 2013 19:12:47 +1000
schrieb Michael Ellerman <michael@ellerman.id.au>:
> On Mon, Apr 22, 2013 at 06:44:13PM +0200, Dennis Schridde wrote:
> For me it is fixed by applying the following patch, it should be in
> v3.10:

I am currently compiling the patched kernel. Will report back with the
results later.

> Does your cellminer actually work? ie. does it run OK?
>=20
> I am using a fractal benchmark I had lying around, and it appears to
> work, and runs fast enough that it must be running on the SPUs (I
> think).
>=20
> So it sounds like we have some weirdness with stuff not appearing in
> /spu, but spu programs are still able to run. Which is odd to say the
> least.

Yes, that seems to be exactly what I see here. The SPE code seems to be
actually running (cellminer reports SPU threads being created and it
runs at 42 Megahash/s - which is coming closer and closer to the
expected ~60Mh/s, given that I started with about 6Mh/s), just /spu is
empty.

--Sig_/y6JmPSpUPSXBINraK69qLHV
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAlF2ddsACgkQjqfyF1DtJW4iuACfWjSF/QswfI4xI6cIpBdyS6Dl
FNsAn04lBg/23+dfYTgWnQN7v32SLwGu
=ruEP
-----END PGP SIGNATURE-----

--Sig_/y6JmPSpUPSXBINraK69qLHV--
