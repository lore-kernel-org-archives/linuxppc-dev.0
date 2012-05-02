Return-Path: <jwboyer@gmail.com>
Received: from mail-qc0-f179.google.com (mail-qc0-f179.google.com
 [209.85.216.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 02DB5B6FA7
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2012 23:51:19 +1000 (EST)
Received: by qcha6 with SMTP id a6so390362qch.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 May 2012 06:51:17 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 2 May 2012 09:51:17 -0400
Message-ID: <CA+5PVA64YFcVrjwedn2V2pC8P87DXC1SEgbua+ZHF3VQr=FDmA@mail.gmail.com>
Subject: Please pull 'next' branch of 4xx tree
From: Josh Boyer <jwboyer@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
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

Hi Ben,

A few patches from Suzie for 47x kexec/kdump support, and some MSI patches
from Mai La.

josh

The following changes since commit ec34a6814988f17506733c1e8b058ce46602591d:

  powerpc: Remove old powerpc specific ptrace getregs/setregs calls
(2012-04-30 15:37:28 +1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git next

for you to fetch changes up to 9c6b2353dfb80ae843b831c03fc53ddc5c3949ff:

  powerpc/44x: Add PCI MSI node for Maui APM821xx SoC and Bluestone
board in DTS (2012-05-03 08:58:21 -0400)

----------------------------------------------------------------
Mai La (2):
      powerpc/44x: Fix PCI MSI support for Maui APM821xx SoC and Bluestone board
      powerpc/44x: Add PCI MSI node for Maui APM821xx SoC and
Bluestone board in DTS

Suzuki Poulose (3):
      powerpc/44x: Fix/Initialize PID to kernel PID before the TLB search
      powerpc/47x: Kernel support for KEXEC
      powerpc/47x: Enable CRASH_DUMP

 arch/powerpc/Kconfig                |    4 +-
 arch/powerpc/boot/dts/bluestone.dts |   25 +++++
 arch/powerpc/kernel/misc_32.S       |  203 +++++++++++++++++++++++++++++++++--
 arch/powerpc/platforms/44x/Kconfig  |    2 +
 arch/powerpc/sysdev/ppc4xx_msi.c    |   42 +++++---
 5 files changed, 252 insertions(+), 24 deletions(-)
