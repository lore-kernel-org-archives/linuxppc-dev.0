Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound6-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 71C03DE17A
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jun 2007 08:09:18 +1000 (EST)
Message-ID: <46730D64.5080800@am.sony.com>
Date: Fri, 15 Jun 2007 15:06:28 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 25/33] Powerpc: Add signed types to bootwrapper
References: <20070615204749.629571012@am.sony.com>>
In-Reply-To: <20070615204749.629571012@am.sony.com>>
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
