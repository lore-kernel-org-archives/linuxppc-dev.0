Return-Path: <jwboyer@gmail.com>
Received: from mail-qc0-f179.google.com (mail-qc0-f179.google.com
 [209.85.216.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 150B4B6F98
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2012 00:41:42 +1100 (EST)
Received: by qcha6 with SMTP id a6so209151qch.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2012 06:41:38 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 16 Mar 2012 09:41:38 -0400
Message-ID: <CA+5PVA4n_G9mtUcExUuJoMWGuWWDh1h1hCPWe-DEy38G5qg40Q@mail.gmail.com>
Subject: Please pull 'next' branch of 4xx tree
From: Josh Boyer <jwboyer@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Ben,

A small pull request for linux-next.  This adds some commits for Bluestone
from APM, and updates the location of my tree in MAINTAINERS back to
kernel.org.

Stephen, could you change linux-next to pull from this tree instead of the
infradead one?

josh

The following changes since commit 01e8ec4417d3c484986af0adaa0ae6632e0a59cd:

  powerpc: Fix power4/970 idle code regression with lockdep
(2012-03-16 09:28:17 +1100)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git next

Josh Boyer (1):
      MAINTAINERS: Update PowerPC 4xx tree

Vinh Nguyen Huu Tuong (3):
      powerpc/44x: The bug fixed support for APM821xx SoC and Bluestone board
      powerpc/44x: Add support PCI-E for APM821xx SoC and Bluestone board
      powerpc/44x: Add additional device support for APM821xx SoC and
Bluestone board

 MAINTAINERS                                |    2 +-
 arch/powerpc/boot/dts/bluestone.dts        |  127 +++++++++++++++++++++++++++-
 arch/powerpc/kernel/cputable.c             |    2 +-
 arch/powerpc/platforms/44x/Kconfig         |    1 +
 arch/powerpc/platforms/44x/ppc44x_simple.c |    2 +-
 arch/powerpc/sysdev/ppc4xx_pci.c           |   70 +++++++++++++++
 6 files changed, 199 insertions(+), 5 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPY0LZAAoJEKMba9ckhs/WDZ4P/2GQjY6H939+bCfRrTE7TwiB
U7HSyTyY4Cai6hCj02tAK8RAFQ0OQHQcPfuVSTHoc3hN3lqhtlJV4ishK7fCAwii
2UTBXs+IAUhbx+6wJtmpEvist6Cx1sxsU4iJBVBuyqZxELF0S/5Xwg6aOKE0vwsH
aL+hiw8zqoCYTbJZ4PE7vf18Iq+PZeVOAlYyFl9r6vKkY4KvQga7vgE2m/uNvueu
WQevSUSLbhknHZfGaQL8MMjLA7yzGmGIyZI/rxkop7xZ2HFuvaahUNBCfsPslUAp
vi7P8h9bPKuN6A6MeSza/l3CIR7tIUvv+uBbCNNlLYBy3+4Xpk6hT6vD94y3nvqK
5kY2vjxTHQmHw8kh4ojnT9OaBnMCLA+dB4V+GejbtNkv/V5Aw3Flv6ILMQVu1dWq
4588bcKY0Xj+mqQbd5yQQGVTJBGXC/k6eDLrzYhOEQU5cSogdGK5kgyv2ydc+5/Z
I/5dQymM2htXUuR6oD0RNIEWWriFGaLvFiZbJJSnxB9s+o6o77AXossxNL0gOEPr
cqr9ZpSuNujaGN2HzTen1TJNAwCM09PES5vhZDdxDC7prtwR+Ke7ElIbDQsRZF34
jcj7WOeyF38C4G01epdCTYzhKe4I1WyT9ugcjE4LOvYfCuI01II142772/hwBC8+
Icccdg6ASNE8cx62TxDl
=SHv8
-----END PGP SIGNATURE-----
