Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CD59F1A0252
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 19:31:37 +1100 (AEDT)
Message-ID: <1446021081.22351.0.camel@ellerman.id.au>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.3-6 tag
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Date: Wed, 28 Oct 2015 17:31:21 +0900
Content-Type: multipart/signed; micalg="pgp-sha1";
 protocol="application/pgp-signature";
 boundary="=-gNpVv/CwcKkJD38txb5r"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-gNpVv/CwcKkJD38txb5r
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull one more powerpc fix for 4.3:

The following changes since commit 8832317f662c06f5c06e638f57bfe89a71c9b266=
:

  powerpc/rtas: Validate rtas.entry before calling enter_rtas() (2015-10-22=
 11:03:25 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powe=
rpc-4.3-6

for you to fetch changes up to 977bf062bba3eb8d03f66d5b4e227e5d7ebc1e08:

  powerpc/dma: dma_set_coherent_mask() should not be GPL only (2015-10-28 1=
4:20:50 +0900)

----------------------------------------------------------------
powerpc fixes for 4.3 #5

 - powerpc/dma: dma_set_coherent_mask() should not be GPL only from Ben

----------------------------------------------------------------
Benjamin Herrenschmidt (1):
      powerpc/dma: dma_set_coherent_mask() should not be GPL only

 arch/powerpc/kernel/dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--=-gNpVv/CwcKkJD38txb5r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJWMIfZAAoJEFHr6jzI4aWAroMP/iNS0H2M+Beoa8G2CGtghsFO
HAuRaDEQZ76D+Bt2clkXzxdLCzu2uwCvmZ7Lv487sW3maOPRG+iY0rNDNdwdtqk1
9StWSUX3CxFJuGXoBKQiS0xASsgnHWPOhmSoD1IIROGeMfPrFV5wFzYGBTMPCXB/
85utuBTly/1L2FeNuPuY5WycQ+zeCaawa9g75NcwkKa3NirShKf4XYsDm9bU20Kq
J2vs+TMEETFisQTEKzJfj2Wvr3CQYJ1qDiVZJQjvLYaM91b1XJiZanUIRvVEezI2
axKO909dTmFZZUnY+/w+QhbWwjVaBVblWcNqLTNeXUcSFgz0I5c4FG4JyhAdsbBq
bsQBL0vid8DJAKqcckTNQkVrrbG+wFvf0QxMbhxwO29kVtEsDRx3uXxkvdmzLC6M
zO1btUVbF3DeujCkv8BLWdRAIAdeWQnCjwAqX5wqgJVu5aohUtvqYd2s5vovIoV6
OLet6B+BXpC9Gd5apwqQHXqObp/+wQBXdZlzx0RzOLrqZdWCEzi1u5QHQ/4eS1//
V1G202k3A4vfqsMIIO7qAwhfHCFzNDPFqzJuipk3DvGGEkhRMsmVexF7A/9mw2Oi
Cx+SYVQaTiLTr846n6LjWML0xj/iI6tnY236o8Bg2ozClDhuUiglPUfVpyECpVzh
KdxEh3t6fgM+CeCjXlJJ
=k1x/
-----END PGP SIGNATURE-----

--=-gNpVv/CwcKkJD38txb5r--
