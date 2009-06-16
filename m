Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 59278B715B
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Jun 2009 16:24:34 +1000 (EST)
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 4CA64DDD0B
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jun 2009 16:24:34 +1000 (EST)
Date: Tue, 16 Jun 2009 16:24:29 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: linux-next: Linus/powerpc tree build warning
Message-Id: <20090616162429.07e74e75.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__16_Jun_2009_16_24_29_+1000_Gzb9ylIXEpZRoNmE"
Cc: Suneel <suneelg@xilinx.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org, Stephen,
	John Linn <john.linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Tue__16_Jun_2009_16_24_29_+1000_Gzb9ylIXEpZRoNmE
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ben,

Today's linux-next build (powerpc ppc44x_defconfig) produced this warning:

drivers/video/xilinxfb.c: In function 'xilinxfb_assign':
drivers/video/xilinxfb.c:328: warning: cast to pointer from integer of diff=
erent size

Introduced by commit dac4ccfb64bcdd5b4c248ccc22903d67486573cd ("fbdev:
Add PLB support and cleanup DCR in xilinxfb driver").
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__16_Jun_2009_16_24_29_+1000_Gzb9ylIXEpZRoNmE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAko3Op0ACgkQjjKRsyhoI8xNuQCcCiGOrayc+L+RtYU6REBuV+wG
C3YAoL9iKmfOpSROt9JiW9vsKu3CHC25
=9WL2
-----END PGP SIGNATURE-----

--Signature=_Tue__16_Jun_2009_16_24_29_+1000_Gzb9ylIXEpZRoNmE--
