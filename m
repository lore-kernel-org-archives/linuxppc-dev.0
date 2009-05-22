Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 3656ADE1A5
	for <linuxppc-dev@ozlabs.org>; Fri, 22 May 2009 11:12:00 +1000 (EST)
Date: Fri, 22 May 2009 11:11:53 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: linux-next: powerpc tree build warning
Message-Id: <20090522111153.38f7bd1c.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__22_May_2009_11_11_53_+1000_Y5oFJdEdanpQ4eJM"
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>, Jan Blunck <jblunck@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__22_May_2009_11_11_53_+1000_Y5oFJdEdanpQ4eJM
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ben,

Today's linux-next build (powerpc ppc64_defconfig) produced this warning:

arch/powerpc/platforms/cell/spufs/inode.c: In function 'spufs_create':
arch/powerpc/platforms/cell/spufs/inode.c:647: warning: label 'out_dput' de=
fined but not used

Introduced by commit 45db9240890d9343c934db1fe82d6e68ac2d28da
("powerpc/spufs: Remove double check for non-negative dentry").

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__22_May_2009_11_11_53_+1000_Y5oFJdEdanpQ4eJM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkoV+9kACgkQjjKRsyhoI8zQcgCeNsNTRVqIIK8BH6uYTvfNIHNM
AhMAnip/giJgZvtsxLi8m+nT9dEqM6d0
=l1V7
-----END PGP SIGNATURE-----

--Signature=_Fri__22_May_2009_11_11_53_+1000_Y5oFJdEdanpQ4eJM--
