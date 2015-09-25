Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 67C6A1A0145
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2015 17:27:47 +1000 (AEST)
Message-ID: <1443166058.9933.1.camel@ellerman.id.au>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.3-3 tag
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: imunsie@au1.ibm.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, vaibhav@linux.vnet.ibm.com
Date: Fri, 25 Sep 2015 17:27:38 +1000
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-cvkv2L4uKUcozMUD8Ry7"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-cvkv2L4uKUcozMUD8Ry7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull two powerpc fixes for 4.3:

The following changes since commit 1f93e4a96c9109378204c147b3eec0d0e8100fde=
:

  Linux 4.3-rc2 (2015-09-20 14:32:34 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powe=
rpc-4.3-3

for you to fetch changes up to d6eb71a6d2eda21c8cd7a4dcd6207a0d94eb6ae7:

  cxl: Fix lockdep warning while creating afu_err_buff attribute (2015-09-2=
3 20:57:13 +1000)

----------------------------------------------------------------
powerpc fixes for 4.3 #2

 - Wire up sys_membarrier()
 - cxl: Fix lockdep warning while creating afu_err_buff from Vaibhav

----------------------------------------------------------------
Michael Ellerman (1):
      powerpc: Wire up sys_membarrier()

Vaibhav Jain (1):
      cxl: Fix lockdep warning while creating afu_err_buff attribute

 arch/powerpc/include/asm/systbl.h      | 1 +
 arch/powerpc/include/asm/unistd.h      | 2 +-
 arch/powerpc/include/uapi/asm/unistd.h | 1 +
 drivers/misc/cxl/sysfs.c               | 2 ++
 4 files changed, 5 insertions(+), 1 deletion(-)




--=-cvkv2L4uKUcozMUD8Ry7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWBPdyAAoJEFHr6jzI4aWAhQIQAK796sY+ERUBfrSKaDGAGnWl
xhNXxn6d4MmEVyu6A6WAk8X0pJyCiLzWfMuFk+jfStYiXQnfXV3LQDg4xT7iaTmW
82munKteS1iv82JRuiNcP3RUuBtTRpL5mlwbCHSWY3xx+n0GZtQLTqoXn5DhUxUg
gcwTrEo7yhafkSSO19gaBVOKAZdWyIF2XOsi4eEO9X9e44jDrF7/TcrR0uXkvVBd
knmnY/yNcXAzujbJ9xo6oxq/Y2cCD3+9VLUU8lEiH2elEq2j5wSAPUK7XKjMQOaQ
epwzGJFjDpmYFIcLy4LhfNvcIzQwR94WDc6RDoUuF+8tavhnJuYnKWRbD5Z9l3tG
N2B/FR5YS0ak4Md84DLgQ+k4IgkrJTXINMptolDVjfuyVCbogE8CI63Uur+aYDdf
fgm+f31cGHGWsHl9fjJUGtE6CtkTSl58YRb5o/QkNDFnTb2lF8+hq0hREPTyCTtA
ckQ/mp2hMSLi6H/XtZT8qrVCvuoLBEY/H2EtiLIs6s02iD1vemgJcomueiPKctq4
Xe3CB75YcPEs7b1UpjJ6vfOjPvmgWLp54qz6YCAqvrS4o5jK4zU1jGIRe/gAG+XO
Ppdfg8yRz9T9Mph3/9EY/7pSQiOmQdawXv1sz4xaH4g59NjKYR3jaijHHW3BqZ1/
zqo2ZniiYg7lwWvfDF/S
=8KxI
-----END PGP SIGNATURE-----

--=-cvkv2L4uKUcozMUD8Ry7--
