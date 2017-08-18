Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xYjTx2wr8zDr3s
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Aug 2017 22:45:09 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.13-7 tag
Date: Fri, 18 Aug 2017 22:45:07 +1000
Message-ID: <87k221jb8s.fsf@concordia.ellerman.id.au>
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

Please pull another powerpc fix for 4.13:

The following changes since commit 96ea91e7b6ee2c406598d859e7348b4829404eea:

  powerpc/watchdog: add locking around init/exit functions (2017-08-09 23:45:33 +1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.13-7

for you to fetch changes up to 5a69aec945d27e78abac9fd032533d3aaebf7c1e:

  powerpc: Fix VSX enabling/flushing to also test MSR_FP and MSR_VEC (2017-08-16 19:35:54 +1000)

----------------------------------------------------------------
powerpc fixes for 4.13 #7

A bug in the VSX register saving that could cause userspace FP/VMX register
corruption. Never seen to happen (that we know of), was found by code
inspection, but still tagged for stable given the consequences.

----------------------------------------------------------------
Benjamin Herrenschmidt (1):
      powerpc: Fix VSX enabling/flushing to also test MSR_FP and MSR_VEC

 arch/powerpc/kernel/process.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJZluFUAAoJEFHr6jzI4aWAFAUQAI14BqOI2rw6VuueiDNsTbAd
8c7gEG4o4egZW3b1ZgNwXP3Qwrp+xxziiy0nSnqoY0wStS051i8KAW/md3KXwVht
ZgAV0KBmOe3Ji3ad9vqqSYno8hj/FFKs2iLnFLoQJs4O8TfVO3C0In4EAAcI6+Un
Y7YE4HVs8KtV+kLO/HG+iZ3akx9rwzTdflSAGHJgCzpvDXZxGHuFakKd3Z+lJWyI
HZhbmXOyvPGen8nq3gTFz8YuORnlngpE5gejxgILD5z6FSQWl8cULMgi0/VYQCHk
Ph0QjeVUVIhKWT7JiRpSxvTSt+/f0bnk2ldbZWvHI2HSHq8eF8TSGvq7oCQBlwX7
afnUWSASxYWOsphYspra3FqjZ26poU5dWrOVssRslzdk89g01hRT/C5ejltQ5GqV
4h+3gpBzTUI4Ujdxc5+1JKPdFtR7XhIUaL8HJuV2VhHTioAADfEhcxezveDfjsHa
8caEjdqavXAGVlAeKMfNXTZ2EPwqbwEePeKTH3fboS6KPJ369lA2M2Tp5aeTbshj
iJZxnd0bYLgpqGbX+r+AkrPYrVJR3CYq+SgCzt3LJgx6frY8mkBXliYo8o4c23+V
9JCogKWSgcu6Y8iWt9TxCEPEeJu3vmLZDktil3jWaOBBSs7DlVFdv6VL+ZrqpU0z
rX4bt272mGSu4LBF7Cfs
=Zl4d
-----END PGP SIGNATURE-----
--=-=-=--
