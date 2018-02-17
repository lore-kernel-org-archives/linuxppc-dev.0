Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zk4rb2VXhzF14G
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Feb 2018 20:45:51 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: clabbe@baylibre.com, clg@kaod.org, cyrilbur@gmail.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 nfont@linux.vnet.ibm.com, npiggin@gmail.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.16-3 tag
Date: Sat, 17 Feb 2018 20:45:46 +1100
Message-ID: <874lmg3q5x.fsf@concordia.ellerman.id.au>
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull some more powerpc fixes for 4.16. Sorry to send a pull
request on the weekend, and a 2nd one this week, but one of these
commits fixes a boot crash which would be good to get in before rc2.

cheers

The following changes since commit 694a20dae6efc3803740971fa9f7c86b8c8d4685:

  Merge tag 'powerpc-4.16-2' of git://git.kernel.org/pub/scm/linux/kernel/g=
it/powerpc/linux (2018-02-14 10:06:41 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/po=
werpc-4.16-3

for you to fetch changes up to 2c10636a0b9c689450e85f9945583920f50337c9:

  powerpc/pseries: Check for zero filled ibm,dynamic-memory property (2018-=
02-16 21:34:14 +1100)

=2D---------------------------------------------------------------
powerpc fixes for 4.16 #3

The main attraction is a fix for a bug in the new drmem code, which was cau=
sing
an oops on boot on some versions of Qemu.

There's also a fix for XIVE (Power9 interrupt controller) on KVM, as well a=
s a
few other minor fixes.

Thanks to:
  Corentin Labbe, Cyril Bur, C=C3=A9dric Le Goater, Daniel Black, Nathan Fo=
ntenot,
  Nicholas Piggin.

=2D---------------------------------------------------------------
Corentin Labbe (1):
      powerpc/pseries: Add empty update_numa_cpu_lookup_table() for NUMA=3Dn

Cyril Bur (1):
      powerpc: Expose TSCR via sysfs only on powernv

C=C3=A9dric Le Goater (1):
      powerpc/xive: Use hw CPU ids when configuring the CPU queues

Nathan Fontenot (1):
      powerpc/pseries: Check for zero filled ibm,dynamic-memory property

Nicholas Piggin (1):
      powerpc/powernv: IMC fix out of bounds memory access at shutdown

 arch/powerpc/include/asm/topology.h       |  3 +++
 arch/powerpc/kernel/sysfs.c               |  6 ++++--
 arch/powerpc/mm/drmem.c                   |  8 ++++++++
 arch/powerpc/platforms/powernv/opal-imc.c |  6 ++++--
 arch/powerpc/sysdev/xive/spapr.c          | 16 ++++++++++------
 5 files changed, 29 insertions(+), 10 deletions(-)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJah/nKAAoJEFHr6jzI4aWAKOgQAItVhwA3tcBOW3NKygCtJM8C
7+8uBaNKRH1lOWTYuzSrV8bXYXK39zn/Y7MqupFv0PBY6iqElRYGMSzpMflvvbgi
JJQtZ23Dxp9fWFUUmHMLKlER9GuM9znLcTG+NBtx8VH6pfhaQ5wjNHsQ06aYb/+z
qfpIVGZO3axsIuzFRuVaI1Lia/8O/6ATsvb0ruzEHTNCVcX3kA/gK/70MwSkvm09
7qUy20Mit2KpZnP9/uWRrYJM2WaMzHIGjJ5BcLqyeex4yEEsjZmkUpPbG/FEN2/O
62mdFnPUDqf73TcPoXJgpcHvK2Z1KyQq3ls+RH2vH+ERTEcE1vDi4xLbfj+D010a
oRfG57rN8AciBI4+y4XyF3rIOAVN4tgKu4dQ4e4V8Mjrd03UJ//stl+mISrIBnRJ
hgyoX8GQiv7uF62kJphg8+Wkve2OY9w9PHDHAovzBgrTdtW9zGkTEoHF1f42XXYA
pFXOWdsbpAzZkAR19MRvRvLsrIreSuZXZGxLxaqqKHKwN56512zmwGkPp7OL3CUt
pRXVS4SgA4HScSMEJlPtw1OPkcFKK2bKYzpoYsKnsfOJujaNCd7qjtLQCyPDjwlm
oj0b1TBy7WekwHpskgjLiTH7OT54A+Ydoe1PlmuoOAqPFXGlx4VfTnNzyMb7K1CC
9ThGh3ChU2dg36svCPTt
=Uj0g
-----END PGP SIGNATURE-----
--=-=-=--
