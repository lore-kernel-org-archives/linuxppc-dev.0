Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 13A5BB71B2
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Jun 2009 16:09:36 +1000 (EST)
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id F401DDDD04
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jun 2009 16:09:35 +1000 (EST)
Date: Tue, 16 Jun 2009 15:58:43 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Greg KH <greg@kroah.com>
Subject: linux-next: manual merge of the driver-core tree with the powerpc tree
Message-Id: <20090616155843.191a455b.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__16_Jun_2009_15_58_43_+1000_9lL/ZKkJEu2s6x8r"
Cc: Roel Kluin <roel.kluin@gmail.com>, linux-kernel@vger.kernel.org,
	ppc-dev <linuxppc-dev@ozlabs.org>, linux-next@vger.kernel.org,
	Geert, Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Tue__16_Jun_2009_15_58_43_+1000_9lL/ZKkJEu2s6x8r
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Greg,

Today's linux-next merge of the driver-core tree got a conflict in
drivers/block/ps3vram.c between commits
6dee2c87ebbe5d7ce8c4c163966a0bd9c02c75ef ("block/ps3: remove driver_data
direct access of struct device") and
03fa68c245cccbcb99035cbabaa13b408ba91ab5 ("ps3: shorten ps3_system_bus_
[gs]et_driver_data to ps3_system_bus_[gs]et_drvdata") from the powerpc
tree and commit db7afa200c4ef6823a2a40e4ea1dd747775be01a ("block/ps3:
remove driver_data direct access of struct device") from the driver-core
tree.

I fixed it up (used the powerpc tree version).  Again, Greg, I think the
driver-core tree version is no longer relevant.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Tue__16_Jun_2009_15_58_43_+1000_9lL/ZKkJEu2s6x8r
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAko3NJMACgkQjjKRsyhoI8xzQgCdFMAYT5I72u80Rfn5w2au880o
ovkAn3mg+NV4OmunvQy+Hw3lUcZekMg7
=FguH
-----END PGP SIGNATURE-----

--Signature=_Tue__16_Jun_2009_15_58_43_+1000_9lL/ZKkJEu2s6x8r--
