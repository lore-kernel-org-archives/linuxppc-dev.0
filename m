Return-Path: <asarai@suse.de>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wfHv90Ff9zDqLR
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Jun 2017 18:49:08 +1000 (AEST)
From: Aleksa Sarai <asarai@suse.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
 linux-arch@vger.kernel.org, Aleksa Sarai <asarai@suse.de>
Subject: [PATCH v2 0/1] tty: add TIOCGPTPEER ioctl
Date: Fri,  2 Jun 2017 18:48:57 +1000
Message-Id: <20170602084858.4299-1-asarai@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Changes in v2:

  * Reordered addition to ioctls.h to follow correct hex ordering.

Aleksa Sarai (1):
  tty: add TIOCGPTPEER ioctl

 arch/alpha/include/uapi/asm/ioctls.h   |  1 +
 arch/mips/include/uapi/asm/ioctls.h    |  1 +
 arch/parisc/include/uapi/asm/ioctls.h  |  1 +
 arch/powerpc/include/uapi/asm/ioctls.h |  1 +
 arch/sh/include/uapi/asm/ioctls.h      |  1 +
 arch/sparc/include/uapi/asm/ioctls.h   |  3 +-
 arch/xtensa/include/uapi/asm/ioctls.h  |  1 +
 drivers/tty/pty.c                      | 71 ++++++++++++++++++++++++++++++++--
 include/uapi/asm-generic/ioctls.h      |  1 +
 9 files changed, 76 insertions(+), 5 deletions(-)

-- 
2.13.0
