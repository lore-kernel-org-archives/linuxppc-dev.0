Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 161D11A01D2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 23:11:01 +1100 (AEDT)
Message-ID: <1448539860.22295.16.camel@ellerman.id.au>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.4-3 tag
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 mikey@neuling.org
Date: Thu, 26 Nov 2015 23:11:00 +1100
Content-Type: multipart/signed; micalg="pgp-sha1";
 protocol="application/pgp-signature";
 boundary="=-bTqvv5eVZSj/isxWHEzF"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-bTqvv5eVZSj/isxWHEzF
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull some more powerpc fixes for 4.4:

The following changes since commit 1ec218373b8ebda821aec00bb156a9c94fad9cd4=
:

  Linux 4.4-rc2 (2015-11-22 16:45:59 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powe=
rpc-4.4-3

for you to fetch changes up to 7f821fc9c77a9b01fe7b1d6e72717b33d8d64142:

  powerpc/tm: Check for already reclaimed tasks (2015-11-23 20:18:03 +1100)

----------------------------------------------------------------
powerpc fixes for 4.4 #2

 - tm: Block signal return from setting invalid MSR state from Michael Neul=
ing
 - tm: Check for already reclaimed tasks from Michael Neuling

----------------------------------------------------------------
Michael Neuling (2):
      powerpc/tm: Block signal return setting invalid MSR state
      powerpc/tm: Check for already reclaimed tasks

 arch/powerpc/include/asm/reg.h  |  1 +
 arch/powerpc/kernel/process.c   | 18 ++++++++++++++++++
 arch/powerpc/kernel/signal_32.c | 14 +++++++++-----
 arch/powerpc/kernel/signal_64.c |  4 ++++
 4 files changed, 32 insertions(+), 5 deletions(-)

--=-bTqvv5eVZSj/isxWHEzF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJWVvbUAAoJEFHr6jzI4aWAaTcP/RctqKJDsHjWmfRZFPhV5Nst
/3GdN2UxK1jW3M7RhojBaYTcg6UOae6bSlrVUCl0H8BPQzrqFZ5b/aAcgBt+AZgm
rLkfQCsykQ95JQlKGj3NQ92xep1X5ewZmnm7EME6e7u7GpECC4rSNTP3OxjHl55N
FpDLrh1IQYCs3a97sdQq4hRvROSWri9UzMO7Mg4akpeiXo6gi51qi7Mx31AIDuYy
sdQ63BmuJ7exImWd9N9tABleyYLvTLJBaLKzHWf7mlrYS7Pc4RkS8YcaZ9eguYKY
VaOqZAEz0vD9Ha6KyYYz+lvOWcu5Al6EBH+hA0ge17do8wYg2C1aD6vU0u6KZbhf
FgJAQMsdGj7gY9MU6Dnj6b3NBBSkiaR4bCYsxkANrcih8LsRBiVO+gWDTdmWKl27
KAEVd0xvQvb/Og4m+jcq8ySB1PiTQEAMJl7YaoEa9H5fabkG5kEtk4lWB+R8D1ke
UOr1ucKBd1kuuMuqpE6zmWYKXkJ3ZADVMjU0ohKgVeAuXjUSaeaTSaHe9dnMyWpw
9fXObncKP6sPmAla5OkHxPmysB82nrk30Ynig+3b2R+eWh1XkqDI28JLQMWNy7uu
Dejh/p78NL8gWoxDgKF2j4Cr0mrCVA/sfc6ZHJ17l466LVMhLEUBW5zrkoL84Iqr
D/0eKooSo3hZwQ4YGn9o
=wgjr
-----END PGP SIGNATURE-----

--=-bTqvv5eVZSj/isxWHEzF--
