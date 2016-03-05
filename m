Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 00F511A032F
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  6 Mar 2016 09:32:24 +1100 (AEDT)
Message-ID: <1457217137.6002.1.camel@ellerman.id.au>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.5-5 tag
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: fbarrat@linux.vnet.ibm.com, imunsie@au1.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 mikey@neuling.org,  oss@buserror.net, peterz@infradead.org,
 ravi.bangoria@linux.vnet.ibm.com
Date: Sun, 06 Mar 2016 09:32:17 +1100
Content-Type: multipart/signed; micalg="pgp-sha1";
 protocol="application/pgp-signature";
 boundary="=-rSaQNpVHmuzWB/ZWZXsG"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-rSaQNpVHmuzWB/ZWZXsG
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull a few more powerpc fixes for 4.5:

The following changes since commit 9ab3ac233a8b4ffcc27c8475b83dee49fc46bc76=
:

  powerpc/mm/hash: Clear the invalid slot information correctly (2016-02-22=
 19:27:39 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powe=
rpc-4.5-5

for you to fetch changes up to 37c5e942bb2eedd98c1cd1fa1f94d79f6b830c38:

  powerpc/fsl-book3e: Avoid lbarx on e5500 (2016-03-03 23:43:05 -0600)

----------------------------------------------------------------
powerpc fixes for 4.5 #4

 - cxl: Fix PSL timebase synchronization detection from Frederic Barrat
 - Fix oops when destroying hw_breakpoint event from Ravi Bangoria
 - Avoid lbarx on e5500 from Scott Wood

----------------------------------------------------------------
Frederic Barrat (1):
      cxl: Fix PSL timebase synchronization detection

Ravi Bangoria (1):
      powerpc/hw_breakpoint: Fix oops when destroying hw_breakpoint event

Scott Wood (1):
      powerpc/fsl-book3e: Avoid lbarx on e5500

 arch/powerpc/kernel/hw_breakpoint.c  |  3 ++-
 arch/powerpc/mm/hugetlbpage-book3e.c | 13 +++++++++++++
 drivers/misc/cxl/pci.c               |  2 +-
 3 files changed, 16 insertions(+), 2 deletions(-)

--=-rSaQNpVHmuzWB/ZWZXsG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJW215xAAoJEFHr6jzI4aWAkeAP/jr6CJWTY2UNzXAMki9J0Ian
S1AzbRWs1e2k0FEdzBSzkhtHqpCs2EOkmP1SDMI7JSZeup+7akla8tusr33v4ZxI
z8TBIDBHqN2Ux4sjJnAYI0On/bkm6HibVQpkl42FFUjDVblbBP/5TY9700LuoSY/
urlvDv46oFuCkN2tyNdLpmIA267q8CPVwP61MhD+ou4v9D22TrNIALNFoo1mqG74
E3c20XzOL+En7jC/6BgUMP54nIjsG2duCHWenFAmMuSdcroZnpmJQkqXo/V/Ia21
po7JK6Wla2G5839xsSinYLYInpcGON9eNw4xblH86mEwQad7xcBkkoWrvQGi2kOV
fkoykK0qQry4BFwwAEeMnaaKACUytRxNOwH8OeRfWSkU7mUxITVMlJUiHOOnOvU+
fXzi6K7EwuaCEkJkR5wtR2J0+XzMiyfgtBVDhHnOscX6aEkdcxtsNsPkfBTRYDwG
qvOThuAyZPYB8sIRXgOghMwjs4P2xjgnjlMnATAqnVsNzKZuqza1Jl71Fd9g2kYA
1TFxNPUrMrcIqz2W8/8tgWU17D/yatykXtEkVf2pEGQKLL2hFUqdFv8M1XAVx4x9
6iPsUlhP/WB7YGcOQcUSRCo7yW3dPqWvo9w7KBadEeKfouU1AYH8+O25AtbB3viB
Wphv64N0G/pVP0qEmk/C
=bgPR
-----END PGP SIGNATURE-----

--=-rSaQNpVHmuzWB/ZWZXsG--
