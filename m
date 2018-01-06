Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zDLdy2PfszDqJk
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Jan 2018 23:37:26 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: benh@kernel.crashing.org, jsperbeck@google.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.15-6 tag
Date: Sat, 06 Jan 2018 23:37:17 +1100
Message-ID: <87y3lbxiwy.fsf@concordia.ellerman.id.au>
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

Please pull one powerpc fix for 4.15:

The following changes since commit 7333b5aca412d6ad02667b5a513485838a91b136:

  KVM: PPC: Book3S HV: Fix pending_pri value in kvmppc_xive_get_icp() (2017-12-22 15:36:24 +1100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.15-6

for you to fetch changes up to ecb101aed86156ec7cd71e5dca668e09146e6994:

  powerpc/mm: Fix SEGV on mapped region to return SEGV_ACCERR (2018-01-02 21:12:33 +1100)

----------------------------------------------------------------
powerpc fixes for 4.15 #6

Just one fix to correctly return SEGV_ACCERR when we take a SEGV on a mapped
region. The bug was introduced in the refactoring of the page fault handler we
did in the previous release.

Thanks to:
  John Sperbeck.

----------------------------------------------------------------
John Sperbeck (1):
      powerpc/mm: Fix SEGV on mapped region to return SEGV_ACCERR

 arch/powerpc/mm/fault.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJaUML+AAoJEFHr6jzI4aWAtcwP/0EkbFECBO4e9vEMmYPNf6gi
1IMOYmQaG+Ha0rIJHHy7s9xtgPsHUr4AEtuk09u88Yr8XFX7eDi2iF9LaV23ifGv
9IrH1TuuVQBJ3KC/QuU81FuEe0I/nZioquYdaPdHmX1F1R/Olwx1HeJI2LNAXkyR
cPH6QLPbwztUvkuZ2LPxcdaSCon8e/Tas0iCcX1X8dmKX0na547Or2d5EoEBH0gW
HmbX3UdiRkTESB+Yeb2E1fbGXYE0OaKbuJKY4udotLqYsaOxWYMZHQsJTEzp/5it
jp2Hds0jIIZ1MLviT4AhRlwzxcVekxb5V3u66rmtYolOn+GBpOFCdQ5J6jMb5Nyq
wVYno8It+DXNgR3eRDZ8CEUp93PQkLR3R8Xo03xvnTbQI0Xju/PBNoN2mRY3puIa
mv+nCvA4CWIYgYT3bl7GgaRhEBAuHsVI5fS3ZtiAjsLKdIT+NP9xARVnk0qSwCbN
ig5qHxlQTlffoWeLr90H3f9a1AfcOM0Wf09/qlGnoD8xMURrmclj10zY8BSCpOY3
5nThc9xCFsDiiLWZYRqLWoyikvDoj2uPYcKm4J9K3SOheZLInpq2ssG0zv6egJo+
AiQ5pqLm7P+1bN7l4GeqVuDIacp1bpfLMVq4oYvBDrZmoDW3Q45KWhPsrjn8On6F
ld23kroYviVjMEccxOuQ
=pYiH
-----END PGP SIGNATURE-----
--=-=-=--
