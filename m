Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id 389D2B6EE7
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2012 01:08:43 +1100 (EST)
Date: Thu, 22 Mar 2012 01:08:31 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Anatolij Gustschin <agust@denx.de>
Subject: Re: Please pull 'next' branch of 5xxx tree
Message-Id: <20120322010831.3773462306b0f8a2753d2205@canb.auug.org.au>
In-Reply-To: <20120321011830.20e20ca0@wker>
References: <20120320180450.5f6dffe4@wker>
 <20120320223017.GB6292@pengutronix.de>
 <1332286341.2982.26.camel@pasglop> <20120321011830.20e20ca0@wker>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Thu__22_Mar_2012_01_08_31_+1100_AJtklSevmasdzmy5"
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Thu__22_Mar_2012_01_08_31_+1100_AJtklSevmasdzmy5
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Anatolij,

On Wed, 21 Mar 2012 01:18:30 +0100 Anatolij Gustschin <agust@denx.de> wrote:
>
> Yes. Stephen, could you please change linux-next to pull from my
> mpc5xxx tree
>=20
>  git://git.denx.de/linux-2.6-agust.git next

I have replaced the 52xx-and-virtex tree with this (and called it simply
mpc5xxx).  I have also removed the 52xx-and-virtex-current tree.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgment of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
	Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

Legal Stuff:
By participating in linux-next, your subsystem tree contributions are
public and will be included in the linux-next trees.  You may be sent
e-mail messages indicating errors or other issues when the
patches/commits from your subsystem tree are merged and tested in
linux-next.  These messages may also be cross-posted to the linux-next
mailing list, the linux-kernel mailing list, etc.  The linux-next tree
project and IBM (my employer) make no warranties regarding the linux-next
project, the testing procedures, the results, the e-mails, etc.  If you
don't agree to these ground rules, let me know and I'll remove your tree
from participation in linux-next.

--Signature=_Thu__22_Mar_2012_01_08_31_+1100_AJtklSevmasdzmy5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPaeDfAAoJEECxmPOUX5FElbEP/3rp7RWkxkQDB07iBZZXuq46
wPkCUW0BPY6iNNQZJ2ko1zqMTW+eoRK6KByKdwqEy37GQOwN3F8Tq3sUt6ioKwKn
5079mtrPMdX6J/wMIEM49L4OqKGXM216ccx5fl0DV0osW8OTgdktcdQpaIV0d1KT
AuPQsapDc2/n8dsL5G/PpE8b2rjB//mvmCiBX4PpfXnvTQfQSKjlB1AwuK7Tbrxe
bMq6z0rrVbt87IKJN93ABsBmA+8ll5e+kM5yj7jNVRqInfnbT271Gv43aMXecx9s
VWRpw9KlYPYAGMgFKvYG20gkPDUaGi25RGqamU++RIad+Vi9CO/hYLnPIkPL7aIk
MpYXLnRkMZeI2w84DD2BkSWJ8raMwSP2OvWuDfsrMc2YWHCHRHHDW2GzOmAp47tF
vaHchdX+UA5j/4Rm6jsTR3dFQaaLoVEljY4Ch1X5kAfq9RwD6WV42KBrHggYLv8X
GpeAB0SOx0PsUpTQP2Qv5wyypG+AokyWHUN7tYcNcdrf25JCKkS+Sn2FikrzEZKN
/LYq29lK7oiR+w+RBbtwIPtxyEkZXIa0KU10M8dez4NPXY9+4mItSwX64E1bQ8jY
+hnqAgpEfSdxXx2cBYJ5dnct2AgCCGR4s2m3R9db0OyI1K8MhVz6lRJtHdfNqoLL
F1G1Htaka+JGn+ArJuoP
=z9Jb
-----END PGP SIGNATURE-----

--Signature=_Thu__22_Mar_2012_01_08_31_+1100_AJtklSevmasdzmy5--
