Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 583431A05D6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2015 11:59:56 +1000 (AEST)
Message-ID: <1432000795.8339.1.camel@ellerman.id.au>
Subject: [git pull] Please pull mpe/linux.git powerpc-4.1-4 tag
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 19 May 2015 11:59:55 +1000
Content-Type: multipart/signed; micalg="pgp-sha1";
 protocol="application/pgp-signature";
 boundary="=-DPyEc8IqW2kXoLIiP2KK"
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org, dja@axtens.net, linuxppc-dev@lists.ozlabs.org,
 aneesh.kumar@linux.vnet.ibm.com, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-DPyEc8IqW2kXoLIiP2KK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull some more powerpc fixes for 4.1:

The following changes since commit 030bbdbf4c833bc69f502eae58498bc5572db736=
:

  Linux 4.1-rc3 (2015-05-10 15:12:29 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mpe/linux.git tags/powerpc-=
4.1-4

for you to fetch changes up to 5e95235ccd5442d4a4fe11ec4eb99ba1b7959368:

  powerpc: Align TOC to 256 bytes (2015-05-14 16:59:21 +1000)

----------------------------------------------------------------
powerpc fixes for 4.1 # 3

- THP/hugetlb fixes from Aneesh.
- MCE fix from Daniel.
- TOC fix from Anton.

----------------------------------------------------------------
Aneesh Kumar K.V (2):
      powerpc/thp: Serialize pmd clear against a linux page table walk.
      powerpc/mm: Return NULL for not present hugetlb page

Anton Blanchard (1):
      powerpc: Align TOC to 256 bytes

Daniel Axtens (1):
      powerpc/mce: fix off by one errors in mce event handling

 arch/powerpc/kernel/mce.c         |  4 ++--
 arch/powerpc/kernel/vmlinux.lds.S |  1 +
 arch/powerpc/mm/hugetlbpage.c     | 25 ++++++++++++++++---------
 arch/powerpc/mm/pgtable_64.c      | 11 +++++++++++
 4 files changed, 30 insertions(+), 11 deletions(-)



--=-DPyEc8IqW2kXoLIiP2KK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABAgAGBQJVWpkbAAoJEFHr6jzI4aWAmwkP/3mBBVZ8o5VKfHQeJThRe91h
4n6Mrvj4zYURQuhpf/WPPHx/buFN4x4EATtDLEAoWAori/2IP/ak7QkiSFdS0BTr
VVLs9MLKo1Tmu2Jd9r6Q+ocVbuur2x05d6HTJlU5BcXVvo/pPqEhHiwwL27eDZ4h
M4ZwJDszGbeH8GTdXVurrayxrZ2N0WUffNl/BwCotmgXjf8VslMGIJja09ZDIKjQ
/MgHrlrg5UOvaAtLS4dW/Z2+lL+luJgMzD9pbEKFkAI+jxUa8MDH8WzrqOu/ku50
oR/0TmWWsYD1ueoR6EInaBSJfvduWWjBSeOU4EgK1sMtauCiD+lD3P+t3sgdClFW
D2eR2nTMjbNAgYWvD7JnJkBS/ZcC8os5Bjfq8SFQiUxRN4xCy15+YbZKIX6QM/iX
TOh1O/qDRuzpIlYqms3D5Wq96Siy8EbvPzotFx6A6dxFBxv7n6jUV4zQXUvvyzOw
I9YyFz7bbzFQxxeHoDs+iybvR5yrLveLpwqEN2Pv/7wG2CRvJxb7cjflBDRbiPk4
6Wf8CbU3sHxA/8vpsyYu6UilQfmVJXZvdjOuuCBZ/CQNSBdt1h2ASERCjBsSdRHW
sugMpTxlfipLwV4dEMtL+ca1jvgpyurSxDrkkLhdgjl0Z4Qc5AENrbl/V0xn2Kg/
0od+E8DYqc52NQATUefg
=Jm3T
-----END PGP SIGNATURE-----

--=-DPyEc8IqW2kXoLIiP2KK--
