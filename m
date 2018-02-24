Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zpCz16f2rzF1mF
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Feb 2018 14:20:45 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: andrew.donnellan@au1.ibm.com, bharata@linux.vnet.ibm.com,
 fbarrat@linux.vnet.ibm.com, jjalvare@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, mikey@neuling.org,
 mlord@pobox.com, mwb@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.16-4 tag
Date: Sat, 24 Feb 2018 14:20:25 +1100
Message-ID: <87sh9r9ipy.fsf@concordia.ellerman.id.au>
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

Please pull some more powerpc fixes for 4.16:

The following changes since commit 91ab883eb21325ad80f3473633f794c78ac87f51:

  Linux 4.16-rc2 (2018-02-18 17:29:42 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.16-4

for you to fetch changes up to eb0a2d2620ae431c543963c8c7f08f597366fc60:

  powerpc/powernv: Support firmware disable of RFI flush (2018-02-23 16:55:42 +1100)

----------------------------------------------------------------
powerpc fixes for 4.16 #4

Add handling for a missing instruction in our 32-bit BPF JIT so that it can be
used for seccomp filtering.

Add a missing NULL pointer check before a function call in new EEH code.

Fix an error path in the new ocxl driver to correctly return EFAULT.

The support for the new ibm,drc-info device tree property turns out to need
several fixes, so for now we just stop advertising to firmware that we support
it until the bugs can be ironed out.

One fix for the new drmem code which was incorrectly modifying the device tree
in place.

Finally two fixes for the RFI flush support, so that firmware can advertise to
us that it should be disabled entirely so as not to affect performance.

Thanks to:
  Bharata B Rao, Frederic Barrat, Juan J. Alvarez, Mark Lord, Michael Bringmann.

----------------------------------------------------------------
Bharata B Rao (1):
      powerpc/mm/drmem: Fix unexpected flag value in ibm,dynamic-memory-v2

Frederic Barrat (1):
      ocxl: Fix potential bad errno on irq allocation

Juan J. Alvarez (1):
      powerpc/eeh: Fix crashes in eeh_report_resume()

Mark Lord (1):
      powerpc/bpf/jit: Fix 32-bit JIT for seccomp_data access

Michael Bringmann (1):
      powerpc/pseries: Revert support for ibm,drc-info devtree property

Michael Ellerman (3):
      powerpc/pseries: Fix duplicate firmware feature for DRC_INFO
      powerpc/pseries: Support firmware disable of RFI flush
      powerpc/powernv: Support firmware disable of RFI flush

 arch/powerpc/include/asm/firmware.h    | 2 +-
 arch/powerpc/kernel/eeh_driver.c       | 3 ++-
 arch/powerpc/kernel/prom_init.c        | 2 +-
 arch/powerpc/mm/drmem.c                | 6 +++---
 arch/powerpc/net/bpf_jit_comp.c        | 3 +++
 arch/powerpc/platforms/powernv/setup.c | 4 ++++
 arch/powerpc/platforms/pseries/setup.c | 3 ++-
 drivers/misc/ocxl/file.c               | 6 ++++--
 8 files changed, 20 insertions(+), 9 deletions(-)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJakNn5AAoJEFHr6jzI4aWAoZ0QAKFGs85ISZD2RIQSQpepBFGx
a80YvoSJ55Jessml+Q/sifO67TDzxw0Ho24mlrmY5TZ+EbQ+MzJJMFgMeR8GhWnB
ij7/B3pavj/f9xGirTajzQroDYr5vQLyRrs6qh7fAcAUE88TcvjchErnGswojcKf
cqB4YUXHcIjjrRctDZabPKLhFb+ZD1743dcr5OmVpKCc3Mq50dQVD3ccMGyG5YVZ
o+WTNuEcoj5r02Z0pRFA8mtP2s/W8HIYEzmLQYiMa3uwdkAvG+KKO6VeNOxIXLbu
dcOV3oRtedlnitjhJq8IiGIV4S8ATmyRNKZcf7tp32FTEmdytkSnteNbAmFspi+A
YhTnleatP5EC0rbBo4Z++tp/XXViDpABCXs7ELOClQA0j4zL65bFjG1KVwF+VrhF
4R6YpQLpoT7G8NNUds0GbvgMgU/CJRMZZ+g8Oh8CKfXw/7Sn22NhlJ2op58f5QYz
BKNd3fc7CBiKaNoDB6d0lyYTwMdRBTlzivuDO+RaeUIzqheloO+fLgTKpFkVHSVX
3yXqIRjHLXXUUf4H+XnKHWPcHZfrb1tkia/XOunZae5VRjZ00nNs+Eu5gLXzNQQV
yLzS0TxXBUNhYCRPoN9BZPyYWvqxLjdYu+pkRILUq2fwcjl4MQ3zjgTHO6JNJtIC
U8Faql2zo2bVyNVBoFAv
=+pki
-----END PGP SIGNATURE-----
--=-=-=--
