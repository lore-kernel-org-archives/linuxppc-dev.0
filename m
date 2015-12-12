Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4EE371A0024
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Dec 2015 08:19:41 +1100 (AEDT)
Message-ID: <1449955171.23425.1.camel@ellerman.id.au>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.4-4 tag
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: alistair@popple.id.au, andrew.donnellan@au1.ibm.com,
 fbarrat@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, paul.gortmaker@windriver.com
Date: Sun, 13 Dec 2015 08:19:31 +1100
Content-Type: multipart/signed; micalg="pgp-sha1";
 protocol="application/pgp-signature";
 boundary="=-gisW/KtYqLXmvc0gJ29Z"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-gisW/KtYqLXmvc0gJ29Z
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull some more powerpc fixes for 4.4:

The following changes since commit 7f821fc9c77a9b01fe7b1d6e72717b33d8d64142=
:

  powerpc/tm: Check for already reclaimed tasks (2015-11-23 20:18:03 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powe=
rpc-4.4-4

for you to fetch changes up to dc9c41bd9ece090b54eb8f1bbdfb1930e10d3ae7:

  Revert "powerpc/eeh: Don't unfreeze PHB PE after reset" (2015-12-09 14:05=
:10 +1100)

----------------------------------------------------------------
powerpc fixes for 4.4 #3

 - opal-irqchip: Fix double endian conversion from Alistair Popple
 - cxl: Set endianess of kernel contexts from Frederic Barrat
 - sbc8641: drop bogus PHY IRQ entries from DTS file from Paul Gortmaker
 - Revert "powerpc/eeh: Don't unfreeze PHB PE after reset" from Andrew Donn=
ellan

----------------------------------------------------------------
Alistair Popple (1):
      powerpc/opal-irqchip: Fix double endian conversion

Andrew Donnellan (1):
      Revert "powerpc/eeh: Don't unfreeze PHB PE after reset"

Frederic Barrat (1):
      cxl: Set endianess of kernel contexts

Paul Gortmaker (1):
      powerpc/sbc8641: drop bogus PHY IRQ entries from DTS file

 arch/powerpc/boot/dts/sbc8641d.dts            |  8 ----
 arch/powerpc/kernel/eeh_driver.c              | 14 ++-----
 arch/powerpc/platforms/powernv/opal-irqchip.c | 58 +++++++++++++----------=
----
 drivers/misc/cxl/native.c                     |  2 +-
 4 files changed, 34 insertions(+), 48 deletions(-)

--=-gisW/KtYqLXmvc0gJ29Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJWbI9jAAoJEFHr6jzI4aWABF4P/2k7jkS+168jqIaLEqy8mOhk
j0LwXQuRbYv+8z/DesRO+N/NGrs8+z7xpOupgDu8o1MFBcM+PxhWKQbbdhfJY5RE
tnHNHFoz+aRIndrjyZqz0ta3UgKb7L8t2GCiGbvzDTw/iqbs5mAjmvas/kr3e4DU
aq1AB/6Mc/r0w0NHO0AviueIW1D2I6DEPjdt4mR9RER40J7xRd+y740fvO8IGWB3
hVcwhM9iIVRWS2u4I00i7NkK7qzabL5PehWp4oGnIWVXK6F298iBwl+FYJVnvpJd
lOFqUeZCbed3IpeEJii2fTpGOVKk0ennPI9jwHwwMxlBDloAdULvvA1GQdpxkyKT
7pPi6sM45cpCEuZMRh0JTsMTzAjnn65iYYj5Q7op8zzbpGRtiRrUn76mmaOXI9YD
FaLfCNv9LravddU0hd1b3TYRJkznCvWi4nv/QILkXXtfK0u381ej6WOqcGXL5Wy6
bfL2JED0sFLOJ7m20Dsk4icruKWRZFjdctYGg5+j0WkQDBfwZpdkFNSq07xy3dlS
kgN9lmkwALHm7SNmJWaSByVCJzeA9ZcZeD5Kfjq6xKlN6JGwneWyS9sALM6edwHD
2bbjLLGWkOiQweksdJf3lqG7JEAadG7c40hSK7iUknSmx6yRC53BceEB0/IXo/37
lJylT0GA4//D9Ro/0W+X
=Si5b
-----END PGP SIGNATURE-----

--=-gisW/KtYqLXmvc0gJ29Z--
