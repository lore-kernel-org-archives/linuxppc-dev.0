Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 844301A0342
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 22:02:57 +1100 (AEDT)
Message-ID: <1456398168.26572.2.camel@ellerman.id.au>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.5-4 tag
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, gwshan@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Thu, 25 Feb 2016 22:02:48 +1100
Content-Type: multipart/signed; micalg="pgp-sha1";
 protocol="application/pgp-signature";
 boundary="=-Ctr+Hlx6elOpRstmOH0C"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-Ctr+Hlx6elOpRstmOH0C
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull a couple more powerpc fixes for 4.5:

The following changes since commit 6ecad912a0073c768db1491c27ca55ad2d0ee68f=
:

  powerpc/ioda: Set "read" permission when "write" is set (2016-02-17 23:52=
:17 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powe=
rpc-4.5-4

for you to fetch changes up to 9ab3ac233a8b4ffcc27c8475b83dee49fc46bc76:

  powerpc/mm/hash: Clear the invalid slot information correctly (2016-02-22=
 19:27:39 +1100)

----------------------------------------------------------------
powerpc fixes for 4.5 #3

 - eeh: Fix partial hotplug criterion from Gavin Shan
 - mm: Clear the invalid slot information correctly from Aneesh Kumar K.V

----------------------------------------------------------------
Aneesh Kumar K.V (1):
      powerpc/mm/hash: Clear the invalid slot information correctly

Gavin Shan (1):
      powerpc/eeh: Fix partial hotplug criterion

 arch/powerpc/kernel/eeh_driver.c  |  3 +--
 arch/powerpc/mm/hash64_64k.c      |  8 +++++++-
 arch/powerpc/mm/hugepage-hash64.c | 12 +++++++++++-
 3 files changed, 19 insertions(+), 4 deletions(-)

--=-Ctr+Hlx6elOpRstmOH0C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJWzt9YAAoJEFHr6jzI4aWAxxwQAJ/+6K1cuaZZ+mE13+ZpgBT9
IBvqXUZoQ4E666kAEz4p+u9EwipgrFnUi+CBXiq+1y2B9cWrSIEQ/h4HVVK/QLUm
Y1W7GJHy+x1umcATV5V/OtKqjZg5cHJ2/VTSFQHBcJxfQss7qRrHB79RxHfFsI7a
S1SLLA/kj/VTudu3kBJIn6+fG2s3X/cewYBbwdBacBfZEG8I27sKsgiqG3Ok0bdE
alZYNT1OiZRUTUbdyWWV43xemEWlIi0fYDqXrO6M4h2rqWzkoP7MvOnSsHdtC1ZU
idF/UBKw+yYaNv3L4h2nqxV8UlOHZsAdDZChbcQflIw2LLzC+wMZQzwtgSFIbi7M
xEUP8Y9TiNKNeHcg4ioHiFy5mAl2T2Csbmv6tLyDSF6/cll8xAQ2MFEg1dUlFtb/
Ar5FukN5kR14jQIFW7NMYLwWWRqMmlEnxu3AexzdggNFFOAytA0tZcmTuXjnkbgS
iaeIIwIDnzROd0j97k2vU4tshIMZZ48EYjtc+ooriypw42mtcqA8h+BejaeOLORS
Ixog1t51hvwM65jx+aT0Yjf+IkisvxG66d/fI0+z24P5cpnprZERd+RHVtZEphPg
yAoq9CYyxMqr1fknyA7CYo3kWJKYVpj/3CVekcshzzXW+EAm4EBerl+CLysSRODZ
5JEtZvQzxGMiaJH2yqx8
=/jFQ
-----END PGP SIGNATURE-----

--=-Ctr+Hlx6elOpRstmOH0C--
