Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4714067A3A
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 20:23:23 +1000 (EST)
Subject: Re: snd-aoa status update / automatic driver loading
From: Johannes Berg <johannes@sipsolutions.net>
To: Eddy =?iso-8859-2?Q?Petri=BAor?= <eddy.petrisor@gmail.com>
In-Reply-To: <60381eeb0605180025v2495715scb345d7067518ecc@mail.gmail.com>
References: <1147860564.14395.6.camel@johannes>
	<60381eeb0605180025v2495715scb345d7067518ecc@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-u0ojfOnD9ADp+PcTrzo9"
Date: Thu, 18 May 2006 12:23:04 +0200
Message-Id: <1147947784.15507.46.camel@johannes>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	debian-powerpc <debian-powerpc@lists.debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-u0ojfOnD9ADp+PcTrzo9
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-05-18 at 10:25 +0300, Eddy Petri=C5=9For wrote:

> Any chance for 5,2 ? What is needed for it? Codec only?

I don't know. If you try loading the modules, the kernel will tell you
something about an unhandled layout id. Alternatively, you can find the
layout-id file in your /proc/device-tree/ and tell me the number in it.
The rest I can figure out.

johannes

--=-u0ojfOnD9ADp+PcTrzo9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARGxLBqVg1VMiehFYAQLYIRAAwTHsA8FDFywMscIQRadkmegCykSB2dtC
V0g+eFJY/IMclmrDmgeuHE0Z5ApUgdbGdN2a7OJ9Zmz+wfmDPf2PIIdx9o6QdkwY
RoU7FNnl69OuUeSjp89os6l/yU/EBfon3VYlevScYgugF11SCIbbvE6XCiEn1Rio
6kJECy73kk96PwPuGlrE77Am2tEYkaDYbTZ1NHNzYS3al1bSRS3E8+i7JEA8qsqm
NZFEc4sMBJEgFc4P8nPK9kbj95qO/aFA9x6xQN3QVDcRdIqzEMhK43hTRR/DehGz
sS5EIYFeSv/QjGgPSICuQg1iXYlftqp51rqgCKR7BmGc12SVKPF3A+cQpJN3jbEC
u9NT2kedtRvtzTVVFGY2rkToRRPLNYMgeFczRKR9Aa1W3wnZZ5TMHO8LhJbiQ0Aq
yOBQml3CocpN9RQNRlH/RmeY1a8DGbGYKdXI//SpnQSH4nSaUQonOILwv/0Iwyd6
xrCCsYtaEoohl/8XcEe7Zu16W4wwZaotItfS9m7OrheeKOIns+Yfj5UnFZSmglsg
gjWLZrK+gswuLs0sfZwnU6YObS3OLymmUMY4QYNGLIP3BDJUio8/TStdXu5F/LEF
IvNdxqFYJ5bW2+7Bdzco7s+M36m/1fFt++6zqZoHLzr4OHp24J159lVt0d8g1Ez+
DFT+gU3SViQ=
=72PX
-----END PGP SIGNATURE-----

--=-u0ojfOnD9ADp+PcTrzo9--
