Return-Path: <B38951@freescale.com>
Received: from AM1EHSOBE005.bigfish.com (am1ehsobe003.messaging.microsoft.com
 [213.199.154.206])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 456F3B73F7
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2012 20:30:31 +1100 (EST)
Received: from mail60-am1 (localhost [127.0.0.1])	by mail60-am1-R.bigfish.com
 (Postfix) with ESMTP id D1A23401FD	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Feb 2012 09:30:16 +0000 (UTC)
Received: from AM1EHSMHS016.bigfish.com (unknown [10.3.201.225])	by
 mail60-am1.bigfish.com (Postfix) with ESMTP id 0E8A4460049	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2012 09:30:14 +0000 (UTC)
From: Jia Hongtao <B38951@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 2/2] powerpc/85xx: update SEC node in dts for MPC8572DS
Date: Wed, 8 Feb 2012 17:27:56 +0800
Message-ID: <1328693276-12057-2-git-send-email-B38951@freescale.com>
In-Reply-To: <1328693276-12057-1-git-send-email-B38951@freescale.com>
References: <1328693276-12057-1-git-send-email-B38951@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: b38951@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add sec3.1 support

Signed-off-by: Jin Qing <b24347@freescale.com>
Signed-off-by: Zhao Chenhui <b35336@freescale.com>
Signed-off-by: Jia Hongtao <B38951@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/boot/dts/fsl/mpc8572si-post.dtsi |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/mpc8572si-post.dtsi b/arch/powerpc/boot/dts/fsl/mpc8572si-post.dtsi
index d44e25a..cdda34f 100644
--- a/arch/powerpc/boot/dts/fsl/mpc8572si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/mpc8572si-post.dtsi
@@ -184,7 +184,7 @@
 /include/ "pq3-etsec1-1.dtsi"
 /include/ "pq3-etsec1-2.dtsi"
 /include/ "pq3-etsec1-3.dtsi"
-/include/ "pq3-sec3.0-0.dtsi"
+/include/ "pq3-sec3.1-0.dtsi"
 /include/ "pq3-mpic.dtsi"
 /include/ "pq3-mpic-timer-B.dtsi"
 
-- 
1.7.5.1
