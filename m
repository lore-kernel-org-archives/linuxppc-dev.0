Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A12591A003D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 13:19:57 +1100 (AEDT)
Message-ID: <1427163597.28572.5.camel@ellerman.id.au>
Subject: [git pull] Please pull mpe/linux.git powerpc-4.0-3 tag
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 24 Mar 2015 13:19:57 +1100
Content-Type: multipart/signed; micalg="pgp-sha1";
 protocol="application/pgp-signature";
 boundary="=-cELSJhHF9ozgtWGNCjYo"
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org, paulus@samba.org, tyreld@linux.vnet.ibm.com,
 mahesh@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-cELSJhHF9ozgtWGNCjYo
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull some powerpc fixes for 4.0:

The following changes since commit 06e5801b8cb3fc057d88cb4dc03c0b64b2744cda=
:

  Linux 4.0-rc4 (2015-03-15 17:38:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mpe/linux.git tags/powerpc-=
4.0-3

for you to fetch changes up to 44d5f6f5901e996744858c175baee320ccf1eda3:

  powerpc/book3s: Fix the MCE code to use CONFIG_KVM_BOOK3S_64_HANDLER (201=
5-03-23 17:10:47 +1100)

----------------------------------------------------------------
powerpc fixes for 4.0 # 2

- Fix the MCE code to use CONFIG_KVM_BOOK3S_64_HANDLER
- Little endian fixes for post mobility device tree update
- Add PVR for POWER8NVL processor
- Fixes for hypervisor doorbell handling

----------------------------------------------------------------
Benjamin Herrenschmidt (1):
      powerpc: Add PVR for POWER8NVL processor

Mahesh Salgaonkar (1):
      powerpc/book3s: Fix the MCE code to use CONFIG_KVM_BOOK3S_64_HANDLER

Paul Mackerras (1):
      powerpc/powernv: Fixes for hypervisor doorbell handling

Tyrel Datwyler (1):
      powerpc/pseries: Little endian fixes for post mobility device tree up=
date

 arch/powerpc/include/asm/ppc-opcode.h     |  3 +++
 arch/powerpc/include/asm/reg.h            |  3 +++
 arch/powerpc/kernel/cputable.c            | 20 ++++++++++++++
 arch/powerpc/kernel/dbell.c               |  2 ++
 arch/powerpc/kernel/exceptions-64s.S      |  2 +-
 arch/powerpc/platforms/powernv/smp.c      | 14 ++++++++--
 arch/powerpc/platforms/pseries/mobility.c | 44 ++++++++++++++++-----------=
----
 7 files changed, 64 insertions(+), 24 deletions(-)



--=-cELSJhHF9ozgtWGNCjYo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABAgAGBQJVEMnNAAoJEFHr6jzI4aWACkUQAIf5w5Yx6zBZupCC4tpiOSug
YEATU/Ih0L8DFcOMsdnmU9uQ2ijRPSiXUw3gSU/iRbV1xZWB0OGmRvEgHqEPy1Q5
IXOAT9zGoeMVwZs6GHarCPm0mO2XgXgqWcZvEBxP4hNBiO+5bV1G+SVTviXk9iUb
WYQEati0rhFOsr2oakP1QjV8V5gMUBNzdQZmT/YqrS2kisjhASrq5n3IFm/Wn7L3
GAZErGssOP587jYauQB0WcWF5SJx+944GtPHejc3H0ASt05ZrVJHO+0svuatwzBu
0vfWweshjswtRsBGshuzrjNYa0WeMjyKCP1CwY1/6E5pgjG5cRJd0OQujssEAIza
FPC01f6ZXev89mwo9E5vG0z+ryFFBxVpHQQw+Y87Mfp4zD8B8jDz7DeLM1w6YjDO
L5gJj4yD+6rFcpyZY+hCrsRqGXS397Qy1CkFqsrKgXNse6nOu65trcKrLBfMbUXt
TWWDK+1Y7xBgr3m8jsXxQ2mbsXQaYfZEku0g3IYyzwNdzHN1lhjLzHlN64Uho/2u
z71ioH7W2B5yHXArWB33WADzR6VhyHpmtxBYmcuQzMfxL7W1WuLJ91CznpnFFfXl
tCD/9ZnGWRfyN4rXMefFWlRE6jL5jPG1UMqdkHGVfFukdECQtcocw5V3GQDP16nV
Z3J1psoylSJcIBU3AqUi
=zQr0
-----END PGP SIGNATURE-----

--=-cELSJhHF9ozgtWGNCjYo--
