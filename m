Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AA56C1A02C2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Oct 2014 17:13:50 +1100 (AEDT)
Message-ID: <1413440004.20705.7.camel@concordia>
Subject: [git pull] Please pull mpe.git for-linus branch (for powerpc)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 16 Oct 2014 17:13:24 +1100
Content-Type: multipart/signed; micalg="pgp-sha1";
 protocol="application/pgp-signature";
 boundary="=-NksMaltrWCP8aPwOPI+U"
Mime-Version: 1.0
Cc: linus.walleij@linaro.org, Liviu.Dudau@arm.com, linux-kernel@vger.kernel.org,
 linuxppc-dev list <linuxppc-dev@ozlabs.org>, bhelgaas@google.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-NksMaltrWCP8aPwOPI+U
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

There was a bit of a misunderstanding between us and the ARM guys in the de=
vice
tree PCI code, which is breaking virtio on powerpc. This is the minimal fix
until we can sort it out properly.

cheers


The following changes since commit 0429fbc0bdc297d64188483ba029a23773ae07b0=
:

  Merge branch 'for-3.18-consistent-ops' of git://git.kernel.org/pub/scm/li=
nux/kernel/git/tj/percpu (2014-10-15 07:48:18 +0200)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/mpe/linux.git for-linus

for you to fetch changes up to aeba3731b150188685225b510886f1370d8814de:

  powerpc/pci: Fix IO space breakage after of_pci_range_to_resource() chang=
e (2014-10-16 14:19:07 +1100)

----------------------------------------------------------------
Michael Ellerman (1):
      powerpc/pci: Fix IO space breakage after of_pci_range_to_resource() c=
hange

 arch/powerpc/kernel/pci-common.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)






--=-NksMaltrWCP8aPwOPI+U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABAgAGBQJUP2IdAAoJEFHr6jzI4aWARvEP/jGscqO0rkyONPO1EOxVBjoE
ft+a7qcUHDCM1CQxYGk6MP4CThbomCvmDfGCBma8nYy6BpxYYEDHLts8X1tZ7gqL
Q+OSS5zI1UyLlZjFs0kT6eGGT/9Gxf9r5Fp+nGX5sHcUYyvUWn75KwDguojxx1pZ
c5I5PfjLea3DTAZKqMqVHw2WaYYiFAxt/AwvbjAEufzsrN0QdCNCOcpmi0XCNZjZ
kZpXElA9AJ7wJKsIpGeEPayMaDPd0V4S7zi0NvKuvAnr1ZTXfbtk9to49XYvXdXb
H7uKj2VsksbPmGhgS+VTllySSubKao5AYtJZ+K/4PUNnkWlz/oiZSNGExoTCnVIr
6lk+m/fUszC2Ill9WfCsYfTGumXyIw4PxBc1jdf30mNTQC4H2Us+sMAskxqOOEZV
qxkA8djXU5aYkZdPJy349w7qNAu0dJRO/V/YdolHl7ux0HXtWRHpKqsy7IT5HKu3
DrrkKj4jxCTAort8+ui+kiDhL6Qs/uY5Rw1JTSpeTGgf1zdb44QvJ4Z8TVUtRR6f
xdrJ2e0aJjPlTHiHuQB4ubL8i2n/WNSUJGtinnN2OJoVVTdPnrE79NavFofZVw5q
C+mrD0qeTegt1dfBFZyEJSmeBNZ381Nwffws0MPNAPyDF0nHad+aykTXibsrPp7G
i4ssU5j5qAQ7pO2qK5Ll
=K7Wa
-----END PGP SIGNATURE-----

--=-NksMaltrWCP8aPwOPI+U--
