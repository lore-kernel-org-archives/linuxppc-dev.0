Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vmBbv09GPzDqY7
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Mar 2017 19:11:07 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: chandan@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, david@gibson.dropbear.id.au
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.11-5 tag
Date: Sun, 19 Mar 2017 19:11:01 +1100
Message-ID: <874lyp660a.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha1; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-=-=
Content-Type: text/plain

Hi Linus,

Please pull a couple of minor powerpc fixes for 4.11:

The following changes since commit fb5fe0fd626c425ed41842c4318aa7ab6f3c2db7:

  Merge tag 'powerpc-4.11-4' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux (2017-03-13 19:48:22 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.11-5

for you to fetch changes up to 8971e1c79d3f6c9a5e6f7a65c50c41f434a4dae6:

  powerpc/pseries: Don't give a warning when HPT resizing isn't available (2017-03-17 16:10:58 +1100)

----------------------------------------------------------------
powerpc fixes for 4.11 #5

 - Wire up statx() syscall
 - Don't print a warning on memory hotplug when HPT resizing isn't available

Thanks to:
  David Gibson, Chandan Rajendra.

----------------------------------------------------------------
Chandan Rajendra (1):
      powerpc: Wire up statx() syscall

Michael Ellerman (1):
      powerpc/pseries: Don't give a warning when HPT resizing isn't available

 arch/powerpc/include/asm/systbl.h      | 1 +
 arch/powerpc/include/asm/unistd.h      | 2 +-
 arch/powerpc/include/uapi/asm/unistd.h | 1 +
 arch/powerpc/platforms/pseries/lpar.c  | 4 +++-
 4 files changed, 6 insertions(+), 2 deletions(-)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYzj0WAAoJEFHr6jzI4aWAJaIP/j9rDULg5T2VOaxjTVfNQdTR
OghCHd0fdXbVJdZNm6nzCMrYsMrOEv/Z/3Su3vFuWz/ldWPsEDH1hCAfAMfQhxZn
7ZWJv2RFRZEZRntXM7IOrcOZGamyTvTLEHMW2mNb1/0WmAixs057upnhkXlLb+NC
97C8/fTfQBWR4o98lNhVLNLFhiH8gXzzKuG76kAOM2ssa7DD5yrSmKAH4WatqqEC
ot6hkiRffzIjt2loKUXY6JAKAcPCCyjdpNwr06oqwXQQg47dCtIkaR0NPlo1M6QO
+13VUEsZGiYuyOqHmiqAOkmckygilb67g7OpTUs95pSjWlQv6sOfRimzpDkqLPcI
ml6D/KYHxyAngK51+8s45mqge6GkVGqRwQ2wlugsU/nJAjXiQAdG1p7rHRXHmKk8
G7XHSfSwWVLO33MqnqNvxemQAjH/Z/Jia2MpOBTiaNkwyQtwhNoTQVNhlqIX2IrD
YvalGpIRFudpv3k8fDHkuUgo13JVgli6INc4Dgux04JKdOK46YAJEyxVenBYPpFB
XBjnepWS53togrrtpw2gl5vt0rHM46Pdnp0dygSiq5B9p6t+F3qub2Pt5HZXDHR7
EVDFxG4wkBLwa9uZwHh2L2s1qravmuR/gEcf+1u/xybZ0y5ldDDxZNK6rEF9iLRo
uxqBjSq1WJh1PpMl7B+k
=zFUs
-----END PGP SIGNATURE-----
--=-=-=--
