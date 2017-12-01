Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ypCpc26VtzDrqC
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Dec 2017 23:13:12 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: andrew.donnellan@au1.ibm.com, bsingharora@gmail.com,
 fbarrat@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, mahesh@linux.vnet.ibm.com,
 naveen.n.rao@linux.vnet.ibm.com, vaibhav@linux.vnet.ibm.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.15-3 tag
Date: Fri, 01 Dec 2017 23:13:11 +1100
Message-ID: <87r2sed4tk.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
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

Please pull some more powerpc fixes for 4.15:

The following changes since commit 4d6c51b107cc73b15a377224549aa5593f90df89:

  powerpc/64s: Fix Power9 DD2.1 logic in DT CPU features (2017-11-22 23:17:01 +1100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.15-3

for you to fetch changes up to 7e4d4233260be0611c7fbdb2730c12731c4b8dc0:

  powerpc: Do not assign thread.tidr if already assigned (2017-11-29 19:56:18 +1100)

----------------------------------------------------------------
powerpc fixes for 4.15 #3

Two fixes for nasty kexec/kdump crashes in certain configurations.

A couple of minor fixes for the new TIDR code.

A fix for an oops in a CXL error handling path.

Thanks to:
  Andrew Donnellan, Christophe Lombard, David Gibson, Mahesh Salgaonkar, Vaibhav Jain.

----------------------------------------------------------------
Mahesh Salgaonkar (1):
      powerpc/powernv: Fix kexec crashes caused by tlbie tracing

Michael Ellerman (1):
      powerpc/kexec: Fix kexec/kdump in P9 guest kernels

Vaibhav Jain (3):
      cxl: Check if vphb exists before iterating over AFU devices
      powerpc: Avoid signed to unsigned conversion in set_thread_tidr()
      powerpc: Do not assign thread.tidr if already assigned

 arch/powerpc/kernel/misc_64.S    |  2 ++
 arch/powerpc/kernel/process.c    | 12 +++++++++---
 arch/powerpc/mm/hash_native_64.c | 15 ++++++++++++---
 drivers/misc/cxl/pci.c           | 12 ++++++++++--
 4 files changed, 33 insertions(+), 8 deletions(-)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJaIUdXAAoJEFHr6jzI4aWAcDgQALuIcy/VwZFLywrlyJxsWVGi
w2CP93WKnkvm/d4KCnX2AkfXCdlCzf3+Y4KTiHtBU8X4QmKuP3aM6ssrXmnVMxfR
F1qNPDyXMD/2CRd2pjrKzqizB8TSFM9eNXOCXxzM5TnD+u/wCThi+VFzJr3tsmIg
SRNC8XpeHcku6Za8B7AcwvYQMLlQPlYyuZPACc8jT7uqfmTGtoa9l/QvVarAfERU
wAjPLRsGrCN//Sc5Chksw8qtsp/BjhvTvkHGkDgHDYz9OwAKSBVKFl2mGdEfuJ0f
rFa7GbNB6ljgbP1Uph1Ru6ArnFTIXEpA7TQrKy/2JB7sBkFmshN4uld8zlCA2V1Q
riDRpSOu6um5M2og+f7NAA6754amVJu+XZ6rLlDfeHDuIp+WzoFnfzFfxIgFRxOz
+k2WCIrUDLXlifGyoLCTTPId4Y4mVHHON1mslzkEQE4q1QDk/q7jLdwAaXS5jhsk
YEl7L/5uXIjoEBIQg/pU7BaDt2DAHiHEJTttB7PdfR0+VnxJQIr2v7CM48algOCk
bhmv3jBRhS4Ns+U5CWRkU/mRQRuZ/WR/C2RpGO65x79HnbnCTj+m8uhgqaJVuphr
k4IkvmkckuaRFSj9yu7D+XeA3UaVimHen24R6HmT3uZVBWCxz2LvyLxJxTgr9/iG
08jMK/38BjrU2BkexAeq
=Knmv
-----END PGP SIGNATURE-----
--=-=-=--
