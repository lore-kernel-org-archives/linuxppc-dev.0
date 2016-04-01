Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qbyRG2KFDzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Apr 2016 21:34:02 +1100 (AEDT)
Message-ID: <1459506833.10340.1.camel@ellerman.id.au>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.6-2 tag
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, oohall@gmail.com, wei.guo.simon@gmail.com
Date: Fri, 01 Apr 2016 21:33:53 +1100
Content-Type: multipart/signed; micalg="pgp-sha1";
 protocol="application/pgp-signature";
 boundary="=-PYBb498G83wfWfWWFHkk"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-PYBb498G83wfWfWWFHkk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull powerpc fixes for 4.6:

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca=
:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powe=
rpc-4.6-2

for you to fetch changes up to 71528d8bd7a8aa920cd69d4223c6c87d5849257d:

  powerpc: Correct used_vsr comment (2016-03-29 12:08:08 +1100)

----------------------------------------------------------------
powerpc fixes for 4.6

 - Fixup preempt underflow with huge pages from Sebastian Siewior
 - Fix altivec SPR not being saved from Oliver O'Halloran
 - Correct used_vsr comment from Simon Guo

----------------------------------------------------------------
Oliver O'Halloran (1):
      powerpc/process: Fix altivec SPR not being saved

Sebastian Siewior (1):
      powerpc/mm: Fixup preempt underflow with huge pages

Simon Guo (1):
      powerpc: Correct used_vsr comment

 arch/powerpc/include/asm/processor.h | 2 +-
 arch/powerpc/kernel/process.c        | 2 +-
 arch/powerpc/mm/hugetlbpage.c        | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

--=-PYBb498G83wfWfWWFHkk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJW/k6RAAoJEFHr6jzI4aWA2x8P/3ITsJfpyKkISKL/hkgY5eN8
jTOtTeTdpz5EQGhFJ0hAbrJAAuJZDtAvqaSbcnL8iGQyeLd+lB6NK+GFlZehmHM/
TVDmGc8DtCoUxbiwmNBAGhL+2sm6cbrCK1n6CFBBUFr7qkJvTpQP5TeJeDlSLRyx
pwuZ4xgFFqKafWNJqSvbky58QBnRW4u15SRbp6iMSes0IQVgdAmftNc5mwHZG3/k
pdkXO8DCmjL4Mqgw5hX86DlqhJhTOXKv0EBYf2TtEQal43eqhQ4tOeHZ7RAOzIlu
7GVWUKYBKidvorYzRkaLq0crWoJPh0kdjBwd8yAT5RhXZ7zVLDaRGWQ61U3nbsxd
g0VuL/kqabKUjz46mA5PcCp2CvtnARF3V8p9E6ANGPf8bIkjzX9TBo1LBnPPKkxS
aid4++xA8dHVY5utP713vRtvhJsllL2d+wvoFUWtv7jw+ndMSpP+7DrDV+fvCTLr
IssURQqfzrB/7eocoyXmGQbumV7nETNpwJBtHqfbKH8+LSoeWMIgwEnobRsxk2hD
3BBCkQUHHejzY84NfNWQnAe6pHTZYkKlmdA0sbPip1E9lIPqkj5Z/APqXdUupCef
zrRC9/utHZ4NpJFAjGce8fhAzkI1521ejpwsOixsm1nD57qqD4b5Px/X612UCpJR
D58RHCMOOm0Cnm/9piHH
=xjMQ
-----END PGP SIGNATURE-----

--=-PYBb498G83wfWfWWFHkk--
