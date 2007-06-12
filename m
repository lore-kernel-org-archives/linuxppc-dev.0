Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-cpk-R.bigfish.com (outbound-cpk.frontbridge.com
	[207.46.163.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 9C09FDE096
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 04:56:16 +1000 (EST)
Message-ID: <466EEBE9.9080800@am.sony.com>
Date: Tue, 12 Jun 2007 11:54:33 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 25/30] Powerpc: Add signed types to bootwrapper
References: <20070612181825.730300780@am.sony.com>>
In-Reply-To: <20070612181825.730300780@am.sony.com>>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add signed types to the powerpc zImage bootwrapper. These are needed by the
PS3 hcall interface.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/boot/types.h |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/powerpc/boot/types.h
+++ b/arch/powerpc/boot/types.h
@@ -7,6 +7,10 @@ typedef unsigned char		u8;
 typedef unsigned short		u16;
 typedef unsigned int		u32;
 typedef unsigned long long	u64;
+typedef signed char		s8;
+typedef short			s16;
+typedef int			s32;
+typedef long long		s64;
 
 #define min(x,y) ({ \
 	typeof(x) _x = (x);	\

-- 
