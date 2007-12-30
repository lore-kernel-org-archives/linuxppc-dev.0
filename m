Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 38ABADDDF9
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Dec 2007 10:45:48 +1100 (EST)
Date: Sun, 30 Dec 2007 17:53:45 -0600
From: Olof Johansson <olof@lixom.net>
To: paulus@samba.org
Subject: Please pull from 'for-2.6.25' branch of pasemi tree
Message-ID: <20071230235345.GA23903@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul,

Please pull from:

  master.kernel.org:/pub/scm/linux/kernel/git/olof/pasemi.git for-2.6.25

For the following pasemi patches:

Olof Johansson (3):
      [POWERPC] pasemi: Implement NMI support
      [POWERPC] pasemi: Distribute interrupts evenly across cpus
      [POWERPC] Enable CONFIG_PCI_MSI and CONFIG_MD in pasemi_defconfig

 arch/powerpc/configs/pasemi_defconfig |   30 ++++++++++++++++++++++++++----
 arch/powerpc/platforms/pasemi/setup.c |   30 +++++++++++++++++++++++++++---
 arch/powerpc/sysdev/mpic.c            |   31 ++++++++++++++++++++++++++++---
 arch/powerpc/sysdev/mpic.h            |    3 ---
 include/asm-powerpc/mpic.h            |   20 +++++++++++++++++++-
 5 files changed, 100 insertions(+), 14 deletions(-)


Thanks,

-Olof
