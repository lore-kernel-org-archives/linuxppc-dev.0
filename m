Return-Path: <glppd-linuxppc-dev-3@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0694B679F1
	for <linuxppc-dev@ozlabs.org>; Mon,  9 May 2005 08:38:17 +1000 (EST)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1DUuIN-00057p-RJ
	for linuxppc-dev@ozlabs.org; Mon, 09 May 2005 00:30:43 +0200
Received: from ppp199-46.lns1.adl1.internode.on.net ([203.122.199.46])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Mon, 09 May 2005 00:30:43 +0200
Received: from toojays by ppp199-46.lns1.adl1.internode.on.net with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Mon, 09 May 2005 00:30:43 +0200
To: linuxppc-dev@ozlabs.org
From: John Steele Scott <toojays@toojays.net>
Date: Mon, 09 May 2005 08:05:18 +0930
Message-ID: <8764xtxs61.fsf@toojays.net>
References: <1115072133.6031.33.camel@gaston>
	<20050503083728.3bedc3ef@colin.toulouse>
	<1115164256.7627.57.camel@gaston>
	<20050507140644.5919b4c3@jack.colino.net> <87k6mamj6o.fsf@toojays.net>
	<20050508113925.36f9989f@jack.colino.net>
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
> On 08 May 2005 at 14h05, John Steele Scott wrote:
>> I finally tried this today, using 2.6.12-rc4, which has this patch.
>> Without USB devices attached, it's okay, but with my USB hub
>> attached, I get a (reproducable) panic in echi_hcd on the way to
>> sleep.
>>=20
>> I took a photo of the panic and enhanced it for readability, it's at
>> <http://www.toojays.net/portal/Members/toojays/ibook-g4-sleep-crash-2.6.=
12-rc4.jpg>.
>
> linux-usb-devel may be interested. (I don't have an usb hub so can't
> test it)

I forwarded the bug report to linux-usb-devel as per Colin's suggestion, and
David Brownell has fixed it. His post, which includes the patch, can be fou=
nd
at <http://marc.theaimsgroup.com/?l=3Dlinux-usb-devel&m=3D111558764113428&w=
=3D2>

cheers,

John

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Messages with missing or bad signatures may have been forged or modified in transit!

iD8DBQBCfpQ00BW7kPcXjRURAiPrAKDvXCjdgBHptx7Axd3t79ze9DRAGwCgwWl1
KWKF9Vs57x/uNA9jcoFmLaU=
=CoU2
-----END PGP SIGNATURE-----
--=-=-=--
