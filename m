Return-Path: <glppd-linuxppc-dev-3@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B1756679EA
	for <linuxppc-dev@ozlabs.org>; Wed, 11 May 2005 10:08:50 +1000 (EST)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1DVeeb-0007MV-PY
	for linuxppc-dev@ozlabs.org; Wed, 11 May 2005 02:00:45 +0200
Received: from ppp199-46.lns1.adl1.internode.on.net ([203.122.199.46])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Wed, 11 May 2005 02:00:45 +0200
Received: from toojays by ppp199-46.lns1.adl1.internode.on.net with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Wed, 11 May 2005 02:00:45 +0200
To: linuxppc-dev@ozlabs.org
From: John Steele Scott <toojays@toojays.net>
Date: Wed, 11 May 2005 09:33:26 +0930
Message-ID: <87u0lar5m9.fsf@toojays.net>
References: <1115072133.6031.33.camel@gaston>
	<20050503083728.3bedc3ef@colin.toulouse>
	<1115164256.7627.57.camel@gaston>
	<20050507140644.5919b4c3@jack.colino.net> <87k6mamj6o.fsf@toojays.net>
	<20050508113925.36f9989f@jack.colino.net> <8764xtxs61.fsf@toojays.net>
	<20050509083553.25d58928@colin.toulouse>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: news <news@sea.gmane.org>
Cc: debian-powerpc@lists.debian.org
Subject: Re: Laptop sleep & current "git" tree
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--=-=-=
Content-Transfer-Encoding: quoted-printable

Colin Leroy <colin@colino.net> writes:
> On Mon, 09 May 2005 08:05:18 +0930
> John Steele Scott <toojays@toojays.net> wrote:
>
>> I forwarded the bug report to linux-usb-devel as per Colin's
>> suggestion, and David Brownell has fixed it. His post, which includes
>> the patch, can be found at
>> <http://marc.theaimsgroup.com/?l=3Dlinux-usb-devel&m=3D111558764113428&w=
=3D2>
>
> Great! Do you know if he plans pushing it to 2.6.12 quickly?=20

I don't know. After fixing that hub issue, I still get an oops if my USB
trackball is connected during sleep.

cheers,

John

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Messages with missing or bad signatures may have been forged or modified in transit!

iD8DBQBCgUvf0BW7kPcXjRURAqqWAKCMjMTcbj7QssJR4aKok0zakdQH9QCcCgfK
MR/j5bwUWLDS5QPynylP0Jk=
=5icQ
-----END PGP SIGNATURE-----
--=-=-=--
