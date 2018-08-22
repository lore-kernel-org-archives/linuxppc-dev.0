Return-Path: <mroos@linux.ee>
Received: from smtp2.it.da.ut.ee (smtp2.it.da.ut.ee
 [IPv6:2001:bb8:2002:500::47])
 by lists.ozlabs.org (Postfix) with ESMTP id 41wVLY08RBzDqC8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2018 00:29:56 +1000 (AEST)
Date: Wed, 22 Aug 2018 17:10:14 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
Sender: mroos@math.ut.ee
To: Linux Kernel list <linux-kernel@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: powerpc compile failure: linux/crc32poly.h: No such file or directory
Message-ID: <alpine.LRH.2.21.1808221159360.13181@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In 4.18 + todays git on 32-bit powerpc:

  BOOTCC  arch/powerpc/boot/decompress.o
In file included from arch/powerpc/boot/../../../lib/decompress_unxz.c:233,
                 from arch/powerpc/boot/decompress.c:42:
arch/powerpc/boot/../../../lib/xz/xz_crc32.c:18:10: fatal error: linux/crc32poly.h: No such file or directory
 #include <linux/crc32poly.h>
          ^~~~~~~~~~~~~~~~~~~


-- 
Meelis Roos (mroos@linux.ee)
