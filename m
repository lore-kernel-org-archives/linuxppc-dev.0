Return-Path: <mfuchs@ma-fu.de>
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net
	[151.189.21.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 964E8DDD04
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Dec 2008 21:59:50 +1100 (EST)
From: Matthias Fuchs <mfuchs@ma-fu.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: add ioctls for RS485 mode control of serial drivers
Date: Tue, 30 Dec 2008 11:59:38 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200812301159.38832.mfuchs@ma-fu.de>
Cc: linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

These ioctls take a struct serial_rs485
(see linux/serial.h) as argument. They are already available
on x86. This patch adds them for the powerpc architecture.

Signed-off-by: Matthias Fuchs <mfuchs@ma-fu.de>
---
 arch/powerpc/include/asm/ioctls.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/ioctls.h 
b/arch/powerpc/include/asm/ioctls.h
index 279a622..1842186 100644
--- a/arch/powerpc/include/asm/ioctls.h
+++ b/arch/powerpc/include/asm/ioctls.h
@@ -89,6 +89,8 @@
 #define TIOCSBRK	0x5427  /* BSD compatibility */
 #define TIOCCBRK	0x5428  /* BSD compatibility */
 #define TIOCGSID	0x5429  /* Return the session ID of FD */
+#define TIOCGRS485	0x542e
+#define TIOCSRS485	0x542f
 #define TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux 
device) */
 #define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
 
-- 
1.5.6.3
