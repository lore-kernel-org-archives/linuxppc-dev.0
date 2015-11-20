Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 764ED1A0018
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2015 22:59:13 +1100 (AEDT)
Message-ID: <1448020746.14769.1.camel@ellerman.id.au>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.4-2 tag
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Denis
 Kirjanov <kda@linux-powerpc.org>
Date: Fri, 20 Nov 2015 22:59:06 +1100
Content-Type: multipart/signed; micalg="pgp-sha1";
 protocol="application/pgp-signature";
 boundary="=-Np/eI/qPbQnHrV2eLeVp"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-Np/eI/qPbQnHrV2eLeVp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull one powerpc commit for 4.4:

The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec=
:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powe=
rpc-4.4-2

for you to fetch changes up to 1451ad03fac3e86948728e0b11f63dee73d3106c:

  powerpc: Wire up sys_mlock2() (2015-11-16 17:05:53 +1100)

----------------------------------------------------------------
powerpc fixes for 4.4

 - Wire up sys_mlock2()

----------------------------------------------------------------
Michael Ellerman (1):
      powerpc: Wire up sys_mlock2()

 arch/powerpc/include/asm/systbl.h      | 1 +
 arch/powerpc/include/asm/unistd.h      | 2 +-
 arch/powerpc/include/uapi/asm/unistd.h | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

--=-Np/eI/qPbQnHrV2eLeVp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJWTwsKAAoJEFHr6jzI4aWAqp4QALJQ9H/3GVvCbIMUorLCJ3JU
MKg7XtBuFo8ZYtZXbtY9ADMr+G6Zlck3FgDKJxceG4NRFi+mm252EPjGEH8bzpdd
Tmopn8BYUTD6xYOujy2JLe1zSH9rE2EoVcljvgVjTekuWu+lRI1AnaDolkjimCS/
b5J3JgrdQdg7t/I6H2y2uNCLLNE+4hH2mP+nUu3hWZpKtuVFPVuKx7Coqhzt1ztG
NSlUdjlgYppBH7Qeiad5lUD94WxMtTLW/krpKlh2lsp1X90Erf9ewfYp/meQ4tUa
LZ0p0qX0QUqpnoP5mp7PATldjj8nSHdeha4VXCKrnlJTc0RxHbuVTZiu2uyJD22c
fl2+V6r8yTW44Cx2dAi0At+DoK6bWEDu/iOruyIIJa754irxAN8RCwlyNPctvCFv
m+IwPiUXEonW663nKZ7DCbNejnLVRPo5uaTOfIJ+qBSnk39DQZqcMYdrrTx6sAE1
qaf61bwlGrS2SsguoE9cXtAHVSstd8dkVcnYNmL2MYelCiyozeB4W1GtGLnll6uL
xKapJI3jEkIfNmeTjtSnOeV5orM6cG83D9jw2rp8swsquG/9fVTWynUF3KAqvwKh
UhxksThYaLaqpSnC2cBztVA28VIZyAv0BdyeXej0rrVp7KREh0wAnnNy5LyJsiOu
YXnYyJV0xWRhw21em2mc
=TIft
-----END PGP SIGNATURE-----

--=-Np/eI/qPbQnHrV2eLeVp--
