Return-Path: <albrecht.dress@arcor.de>
Received: from smtp5.netcologne.de (smtp5.netcologne.de [194.8.194.25])
	by ozlabs.org (Postfix) with ESMTP id 96EF6B7D5B
	for <linuxppc-dev@ozlabs.org>; Fri,  7 May 2010 03:54:35 +1000 (EST)
Date: Thu, 06 May 2010 19:54:31 +0200
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: Re: [Patch v2 1/2] 5200/mpc: improve i2c bus error recovery
To: "Ira W. Snyder" <iws@ovro.caltech.edu>, Grant Likely
	<grant.likely@secretlab.ca>
In-Reply-To: <20100505220916.GD3529@ovro.caltech.edu> (from
	iws@ovro.caltech.edu on Thu May  6 00:09:16 2010)
Message-Id: <1273168472.1767.1@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=PGP-SHA1; boundary="=-GESm4MLGNwyJwiypmWfs"
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>,
	Devicetree Discussions <devicetree-discuss@lists.ozlabs.org>,
	"Ben Dooks \(embedded platforms\)" <ben-linux@fluff.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-GESm4MLGNwyJwiypmWfs
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 06.05.10 00:09 schrieb(en) Ira W. Snyder:
> Did this series get forgotten about? I don't see it in bjdook's next-i2c =
branch or in benh's next branch.

It's not in Grant's 5xxx tree either - as it's specific for those processor=
s, I think he might be the responsible person.  The patch is still in a "ne=
w" state in patchwork, btw.

> I've pulled these into my 2.6.31.13 kernel, and they seem to work fine. Y=
ou've got my Tested-by if you didn't get one from me already.

Tanks a lot!

I think, though, the whole stuff has been discussed in depth in February, s=
o I do not understand why it's still pending as "new".  Grant, did we miss =
something here?

Thanks, Albrecht.

--=-GESm4MLGNwyJwiypmWfs
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iD8DBQBL4wJXn/9unNAn/9ERAnIKAKCtGrks2uRqLy0dIrGrUdSvLi/MvQCgy3zK
QTMSuK41i8DzgaFSXhZrZUY=
=khvH
-----END PGP SIGNATURE-----

--=-GESm4MLGNwyJwiypmWfs--
