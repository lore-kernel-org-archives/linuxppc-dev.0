Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3A96E1A01ED
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2015 10:46:22 +1000 (AEST)
Message-ID: <1440722781.29255.2.camel@ellerman.id.au>
Subject: [git pull] Please pull powerpc/linux.git powerpc-4.2-4 tag
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: gpiccoli@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com, mst@redhat.com
Date: Fri, 28 Aug 2015 10:46:21 +1000
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-uvDIPCCU3azg+OX5LIXq"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-uvDIPCCU3azg+OX5LIXq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull one fix for powerpc for 4.2:

The following changes since commit c13dcf9f2d6f5f06ef1bf79ec456df614c5e058b=
:

  Linux 4.2-rc8 (2015-08-23 20:52:59 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powe=
rpc-4.2-4

for you to fetch changes up to 4d9aac397a5d8f4ee26a4178b5e4a5c474a3a76a:

  powerpc/PCI: Disable MSI/MSI-X interrupts at PCI probe time in OF case (2=
015-08-26 21:40:50 +1000)

----------------------------------------------------------------
powerpc fixes for 4.2 #3

- Fix MSI/MSI-X on pseries from Guilherme

----------------------------------------------------------------
Guilherme G. Piccoli (2):
      PCI: Make pci_msi_setup_pci_dev() non-static for use by arch code
      powerpc/PCI: Disable MSI/MSI-X interrupts at PCI probe time in OF cas=
e

 arch/powerpc/kernel/pci_of_scan.c | 3 +++
 drivers/pci/probe.c               | 2 +-
 include/linux/pci.h               | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)



--=-uvDIPCCU3azg+OX5LIXq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJV369dAAoJEFHr6jzI4aWAxi8QAKJMGJuCUwe3phQsl9DHCDli
FcA3EUsINAvJr8QjHY+cdhieDujNxwTlZIxgUQUSpGCCejCeeIzcSlejwFNYIv6g
ZGeO292ZWsZzNIkKlshOStl+pjwO2sXFi+jCgIKwrEah0vrVm3JkWVnPAZEdh5xY
lCJC4O8+13g4HQ32xDShSr3eWstY5m0/tMpYCy9camZBCu1bHU7qFlf7kuVJu+qg
pyqNTAI7p37nkgT4FRkuAI4jFY00AHbEL2w9Kp5f6w7MfJ8gbgBwKFmkyVPZ/1aX
fA1WgwUPDaCdRnf3DJJ3myIc3EEC/gDYYxcdyP3WGNsxcsyfk+U8fAsZeIB02uPB
X46/uZUjVi25e5yYFfSMm9coCKxWn8Eia0PTJ1t7AjTDOva32K5XtqGZHUJuT55K
J5DIkYh0v/UXk0YLJr8leR583Jy+wtssa73HVy9+Un5VyIsshcEXQ3Sj3dpLsFWp
beU0Jp5pNuQNngN4Zem4Rk9awjW1zMDgezEcn9ghfLs9UsaU4ZoBNotZIBKFUx6H
j3Ks+f9zTjmNRKjMUZGMqcHVRAEsQmO89s2XHxep4YVHuB3iOLZROEEQeqK7wXHC
XWdaqJsjHW56wrUC7ow/kTzOkfgrMyVuwuGbR+byFfinQghdUtv4DBaIWewhJLxU
pr80Kq0aoKOX5ErtLBpo
=RS84
-----END PGP SIGNATURE-----

--=-uvDIPCCU3azg+OX5LIXq--
