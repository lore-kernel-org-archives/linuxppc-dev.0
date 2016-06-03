Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rLjVM4mGJzDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jun 2016 22:06:03 +1000 (AEST)
Message-ID: <1464955556.21530.3.camel@ellerman.id.au>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.7-2 tag
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, gwshan@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 paulus@ozlabs.org,  ruscur@russell.cc, thuth@redhat.com
Date: Fri, 03 Jun 2016 22:05:56 +1000
Content-Type: multipart/signed; micalg="pgp-sha1";
 protocol="application/pgp-signature";
 boundary="=-nQzxYW904nidgQufUvrS"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-nQzxYW904nidgQufUvrS
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull the first batch of powerpc fixes for 4.7:

The following changes since commit 1a695a905c18548062509178b98bc91e67510864=
:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powe=
rpc-4.7-2

for you to fetch changes up to 7cc851039d643a2ee7df4d18177150f2c3a484f5:

  powerpc/pseries: Add POWER8NVL support to ibm,client-architecture-support=
 call (2016-06-01 13:47:34 +1000)

----------------------------------------------------------------
powerpc fixes for 4.7

 - Handle RTAS delay requests in configure_bridge from Russell Currey
 - Refactor the configure_bridge RTAS tokens from Russell Currey
 - Fix definition of SIAR and SDAR registers from Thomas Huth
 - Use privileged SPR number for MMCR2 from Thomas Huth
 - Update LPCR only if it is powernv from Aneesh Kumar K.V
 - Fix the reference bit update when handling hash fault from Aneesh Kumar =
K.V
 - Add missing tlb flush from Aneesh Kumar K.V
 - Add POWER8NVL support to ibm,client-architecture-support call from Thoma=
s Huth

----------------------------------------------------------------
Aneesh Kumar K.V (3):
      powerpc/mm/radix: Update LPCR only if it is powernv
      powerpc/mm/hash: Fix the reference bit update when handling hash faul=
t
      powerpc/mm/radix: Add missing tlb flush

Russell Currey (2):
      powerpc/pseries/eeh: Handle RTAS delay requests in configure_bridge
      powerpc/pseries/eeh: Refactor the configure_bridge RTAS tokens

Thomas Huth (3):
      powerpc: Fix definition of SIAR and SDAR registers
      powerpc: Use privileged SPR number for MMCR2
      powerpc/pseries: Add POWER8NVL support to ibm,client-architecture-sup=
port call

 arch/powerpc/include/asm/reg.h               |  6 ++--
 arch/powerpc/kernel/prom_init.c              |  1 +
 arch/powerpc/mm/hash_utils_64.c              | 22 +++++++++++--
 arch/powerpc/mm/pgtable-book3s64.c           |  5 +--
 arch/powerpc/mm/pgtable-radix.c              | 23 ++++++-------
 arch/powerpc/platforms/pseries/eeh_pseries.c | 49 +++++++++++++++++++-----=
----
 6 files changed, 68 insertions(+), 38 deletions(-)

--=-nQzxYW904nidgQufUvrS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJXUXKkAAoJEFHr6jzI4aWAjw8QAKaCGW2Je8xlM00ik7Deseui
bJFFyXC3BVnpeHhnJiP57yH51CaoofvZwY4nNJafJ2rfWfLHBaDvkdikhIODHB1Z
HsU40lmwGUa+hTntIRX6E55fke5aFF9VVzmG8tEhwtXeRNjMd0YExJhe9TB9U8v/
9IsjG3YkV63FGFNgFdnlHkEBlEGJd2iBkZysWg5SzT381zHjuW5SJWwIEjkn3h2G
q0nGX5Q4tY+SZ+8OsOK9yFJLxXBnVMuGTf3Im2UH1ZQuKf+aRuWDh5DwRZd4MMVJ
yf3UbSfZPDaZZr1jZ2p8k8NNk/nth+qNwPBtan46R8RW9DjiesmBRSPhptLNivPZ
olm4NcOB7yX1JDBD9W8h+Vy3LAhD3c322nSSN2eWhxYo3VVyZN89heDCOhe8QXS0
S9oXj8cxmVtS9ENwo2XMD3QPbgm1KdfWKbkatHMwZIzGkl0LNdvDSDsbpMibuu2+
L5/3iGwlO+p8hq7T7RdA9KAzgYG8Ek+PJq/JFEPpBaqdyePv1MfkFr3/lNDBCNZ+
/VoDImVyIh5cGoUhs9JB3/vY74BaAGa2u1nTWEwtEwEuOvi6oZ8lASEpc+L9ydB+
rt8bK+pMikrhZAJjWTVJxT5xIFQ5lNcx5rYY9JoxV23tTfO8Y4ymaFiM5/vZzpya
gvFJCoS0QZEs1jInQRtw
=LU5N
-----END PGP SIGNATURE-----

--=-nQzxYW904nidgQufUvrS--
