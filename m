Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdzHS4Fr8zDrVm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Aug 2017 21:20:52 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Nicholas Piggin  <npiggin@gmail.com>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.13-8 tag
Date: Fri, 25 Aug 2017 21:20:50 +1000
Message-ID: <87wp5rsxkd.fsf@concordia.ellerman.id.au>
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

Please pull one more powerpc fix for 4.13:

The following changes since commit 5a69aec945d27e78abac9fd032533d3aaebf7c1e:

  powerpc: Fix VSX enabling/flushing to also test MSR_FP and MSR_VEC (2017-08-16 19:35:54 +1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.13-8

for you to fetch changes up to 1a92a80ad386a1a6e3b36d576d52a1a456394b70:

  powerpc/mm: Ensure cpumask update is ordered (2017-08-18 13:07:16 +1000)

----------------------------------------------------------------
powerpc fixes for 4.13 #8

Just one fix, to add a barrier in the switch_mm() code to make sure the mm
cpumask update is ordered vs the MMU starting to load translations. As far as we
know no one's actually hit the bug, but that's just luck.

Thanks to:
  Benjamin Herrenschmidt, Nicholas Piggin.

----------------------------------------------------------------
Benjamin Herrenschmidt (1):
      powerpc/mm: Ensure cpumask update is ordered

 arch/powerpc/include/asm/mmu_context.h      | 18 ++++++++++++++++++
 arch/powerpc/include/asm/pgtable-be-types.h |  1 +
 arch/powerpc/include/asm/pgtable-types.h    |  1 +
 3 files changed, 20 insertions(+)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJZoAgTAAoJEFHr6jzI4aWA3zgQAJOvAIZ3aHPoJ48VOhqyMwnY
i8dW+91Wc9E6ECqCRJyCm9o5Ntx8DAVLL3tKU/Uay8lA3egFQ9YBxfUFakkAvdQf
HNLWoiabvXQT4h6MAX2HGRuohnaLMPnuiqITK6FTMyJwLGrQFL3gOmewQGFSl/Xs
/1TnOiwwCS2XN3CiE1pKZq6rzo7Fyds8oJIZdlzXQUwgV1QKEkFub9tAqdgeoMTL
o8dP/HK4poj2HXqEshXV4ZOAik+7h9I+hnlJhxX0ZZcLOTaqPc9JKRaj8PV4Kt1K
fx9q3Bud4xno7Wpm3MDpnN3vMceqZMWKX9t4wOjyjUpm7Vz7Xc244Tbu7K6AKUxF
gc9IwqFWeHOk6mQZMRLtSnzuLuJc1nHWjuFUB6bARRHPYpOcyRBhyeY1Ka43Q8ho
iDi+vKgS3Pb58MV4CsE3Tt1GjC2CVRoR8ejB9H39zBePXoogSEuPRhk3QZHe5c00
mUUr+Q5BzyRwYFnHiGuPhrc9e3a4xI/6ExliqP6VmdIbp2mYizTYcu9iEla+m4Mn
nO0i9c1B58oBePVGoOgkBQCeecXg8ti0bZ2Rw9yzaU8Ju5Gpvj6WU5ahM6szPcj2
ECnjZiRCnpyMKvr06S0A57rrMsTJTZe08jY1STszvtcjQiPDTAJwZ/QOw2DBW4Pu
/WlPcttSiB3jXyK3wYmu
=ovp+
-----END PGP SIGNATURE-----
--=-=-=--
