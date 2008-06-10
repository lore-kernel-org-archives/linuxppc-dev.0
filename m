Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id DDC6FDDE98
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jun 2008 16:44:54 +1000 (EST)
Date: Tue, 10 Jun 2008 16:44:30 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Greg KH <greg@kroah.com>
Subject: linux-next: powerpc/drivers-core merge conflict
Message-Id: <20080610164430.5272d3b4.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__10_Jun_2008_16_44_30_+1000_sCAQRe7GDLqd=AO_"
Cc: linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>, Kay Sievers <kay.sievers@vrfy.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__10_Jun_2008_16_44_30_+1000_sCAQRe7GDLqd=AO_
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Greg,

Today's linux-next merge of the powerpc tree got a conflict in
arch/ppc/syslib/ppc_sys.c, arch/ppc/platforms/cpci690.c,
arch/ppc/platforms/ev64260.c, arch/ppc/platforms/ev64360.c,
arch/ppc/platforms/hdpu.c, arch/ppc/platforms/katana.c, and
arch/ppc/platforms/radstone_ppc7d.c between commit
09a99031899ba31e43545b9876fb29c3709f21b3 ("driver-core: prepare for
removal of 20 char limit from struct device") from the driver-core tree
and commit ecc688ed0470015664987e23138c7e6355de31b9 ("powerpc: Remove
arch/ppc and include/asm-ppc") from the powerpc tree.

Obviously, the later commit removes the files modified by the former.  I
would guess that you can now remove the parts of the driver-core patch
that would affect those files.  I don't think it will matter if arch/ppc
doesn't build for part of the next merge window.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__10_Jun_2008_16_44_30_+1000_sCAQRe7GDLqd=AO_
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhOIs4ACgkQTgG2atn1QN8qOgCfXkSXAsSLAIRYY3xz0A4AnWvm
PZQAn2PdZw6P0DAVPNX6bno33mhRtMLs
=Ehy5
-----END PGP SIGNATURE-----

--Signature=_Tue__10_Jun_2008_16_44_30_+1000_sCAQRe7GDLqd=AO_--
