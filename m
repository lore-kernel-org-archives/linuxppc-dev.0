Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rhqV46XbPzDqnK
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  3 Jul 2016 09:38:36 +1000 (AEST)
Message-ID: <1467502701.25625.1.camel@ellerman.id.au>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.7-5 tag
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: cyrilbur@gmail.com, darren@stevens-zone.net, gwshan@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Michael
 Neuling <mikey@neuling.org>
Date: Sun, 03 Jul 2016 09:38:21 +1000
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-8xoIaRlAKXzlwTusTSNZ"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-8xoIaRlAKXzlwTusTSNZ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull some more powerpc fixes for 4.7:

The following changes since commit 844e3be47693f92a108cb1fb3b0606bf25e9c7a6=
:

=C2=A0 powerpc/bpf/jit: Disable classic BPF JIT on ppc64le (2016-06-23 10:3=
5:31 +1000)

are available in the git repository at:

=C2=A0 git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags=
/powerpc-4.7-5

for you to fetch changes up to bfa37087aa04e45f56c41142dfceecb79b8e6ef9:

=C2=A0 powerpc: Initialise pci_io_base as early as possible (2016-06-30 16:=
52:29 +1000)

----------------------------------------------------------------
powerpc fixes for 4.7 #5

=C2=A0- tm: Always reclaim in start_thread() for exec() class syscalls from=
 Cyril Bur
=C2=A0- tm: Avoid SLB faults in treclaim/trecheckpoint when RI=3D0 from Mic=
hael Neuling
=C2=A0- eeh: Fix wrong argument passed to eeh_rmv_device() from Gavin Shan
=C2=A0- Initialise pci_io_base as early as possible from Darren Stevens

----------------------------------------------------------------
Cyril Bur (1):
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0powerpc/tm: Always reclaim in start_thr=
ead() for exec() class syscalls

Darren Stevens (1):
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0powerpc: Initialise pci_io_base as earl=
y as possible

Gavin Shan (1):
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0powerpc/eeh: Fix wrong argument passed =
to eeh_rmv_device()

Michael Neuling (1):
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0powerpc/tm: Avoid SLB faults in treclai=
m/trecheckpoint when RI=3D0

=C2=A0arch/powerpc/include/asm/book3s/64/pgtable.h |=C2=A0=C2=A01 +
=C2=A0arch/powerpc/kernel/eeh_driver.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A02 +-
=C2=A0arch/powerpc/kernel/pci_64.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=
=A01 -
=C2=A0arch/powerpc/kernel/process.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 10 +++++
=C2=A0arch/powerpc/kernel/tm.S=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0| 61 ++++++++++++++++++++--------
=C2=A0arch/powerpc/mm/hash_utils_64.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A04 ++
=C2=A0arch/powerpc/mm/pgtable-radix.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A05 +++
=C2=A07 files changed, 65 insertions(+), 19 deletions(-)


--=-8xoIaRlAKXzlwTusTSNZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXeFBtAAoJEFHr6jzI4aWA4AQP/AyXKriU7Vx24rW2HiWDVogZ
UVtMAw2kZIFxgaB9gmp6Bof35oi9ejLMN4q2zy+9c2/4Q+bj6iserAvcw7buzCN/
xqK5X8S250FWw7dMJ2/G54DKWDi4G7CbiG50tTS5JPmav9bqee6sP1F9bXxcIP8Y
z3M2ml67FTWpVCTKcjObj9ROSvngxEuLjxStojdDlO+WCtNvhlp4WjqIWxd1cCVm
8KozYmk6rkHO2rzojsPEQeyxxwKfjg0CgtwQi7+xoeL5vwOUyRhM44Nm5pgCEgdD
QSCUV0cx+yuMUALwybymkyQ8qId31AtX2ZqZ2PZqzq3zzt1eZJF/WzDxASw/2hKf
CgFLdZFjegBmW9J6Jkl8vUzFGqj+APtKKdsk12fG6sxAao/9nY2tVp1pCJ7JG1Kp
HqGNVaGa+cM2vEIz+6ryISAiKiY41YOcc/iTGYHWvo+3HzPL5hPgWFXl4QKyIGAD
2AXfK0E8FF/a0Fytustl55b3kY0U6SqB466GV9XPr3zX94aftQGWCc00quWHYEeo
DfbIhz0Rd+kWHEPG++DjjmPfp4kKgBws5NHe+MB9xMsGsEHqlczdPKmYgNFZKFbz
2P+iM6nDeSsQqXDu67YbzYFya6IrL32PNedh+dDjxuwwi5puNHIIvVMzMAAXZc5K
2TVVl93XcnMXPVeXcckt
=xs+I
-----END PGP SIGNATURE-----

--=-8xoIaRlAKXzlwTusTSNZ--
