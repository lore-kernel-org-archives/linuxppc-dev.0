Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id 4BF96B6FD2
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Mar 2012 17:48:22 +1100 (EST)
Date: Fri, 9 Mar 2012 17:48:08 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: linux-next: manual merge of the irqdomain tree with the powerpc tree
Message-Id: <20120309174808.88d351153355f3783d24b33e@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Fri__9_Mar_2012_17_48_08_+1100_bWlGETrHCrklAJvJ"
Cc: linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Fri__9_Mar_2012_17_48_08_+1100_bWlGETrHCrklAJvJ
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Grant,

Today's linux-next merge of the irqdomain tree got a conflict in
arch/powerpc/platforms/iseries/irq.c between commit 8ee3e0d69623
("powerpc: Remove the main legacy iSerie platform code") from the  tree
and three commits from the irqdomain tree.

I just removed the file.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Fri__9_Mar_2012_17_48_08_+1100_bWlGETrHCrklAJvJ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPWaeoAAoJEECxmPOUX5FEfzEP/2dAFFqzzJUwQhZ2oyUiMgLX
48INrlRmaFpkddbbgbon1PCkpVu9khmnaJVh82A5hb6TXj67K5/7Pt5+idxLqUmr
u0Yb8WSz9VnA+/NMiturI2xLp4lg5Bi8ytCHgm6DLArezTZwR6Vga1foTVmQY4PE
R/Kgxneu/z5dt/BzU873hiVdkivi7PxVZrMguNObg2YhPFr1S8oWCUVeoyd28ABz
+4iP0YkYMKaVNuFAw1Fpne/Lm4d2UzaJGb1/RGWh+9rYb/MZQ//sLdZaB0WFThcW
mC1iuamVRqKwWLRGQw3aC+Yr6ruBAnGVI25sw3OW4tP72b4m92PYRx6KCX+HBks+
sKk9YCJQ7bNoKJyfjpskIwKjV84V0unB+6lx2GBiC9Ms9adTum8JzEuFvUHWQzWg
9cx5hF0Ko6RreeOsirVC7W/b7M9XQP6p3wsWqiPCHFptfEbvWr52wyGMwlo52fXo
MHxHoi0ZQxgfBTvjvp9od1sGvQ9uZnISPNHdxM8LMzrYIJZHU3pCPKUMbgkHuLsU
+ILTsGdJcVXz/tABMuJ5BXfdPCHWAhCCGWtvYg9KzKIv4bWbqBrdlX01jgSNzZ58
uckECGNtuMlYinZCDSXwff3cGitEo5aMJv1/TEeF+W5KNX+9NpSdXeF8ZlQIUzYw
RBL9wd9HNEG0x9QgxSWk
=j+ie
-----END PGP SIGNATURE-----

--Signature=_Fri__9_Mar_2012_17_48_08_+1100_bWlGETrHCrklAJvJ--
