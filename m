Return-Path: <lists@nerdbynature.de>
Received: from trent.utfs.org (trent.utfs.org [194.246.123.103])
	by ozlabs.org (Postfix) with ESMTP id 1F626B6F7E
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  1 Jun 2011 11:22:09 +1000 (EST)
Date: Tue, 31 May 2011 18:22:05 -0700 (PDT)
From: Christian Kujau <lists@nerdbynature.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] document udbg-immortal
Message-ID: <alpine.DEB.2.01.1105311817240.21697@trent.utfs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Back in 2006 the "udbg-immortal" kernel option has been introduced:

  > commit 3b5e905ee3bd23e9311951890aba57a0dbc81ca4
  > Author: Benjamin Herrenschmidt <benh@au1.ibm.com>
  > Date:   Wed Jun 7 12:06:20 2006 +1000
  >
  >  [PATCH] powerpc: Add udbg-immortal kernel option

...but I could not find it documented anywhere in the sources. 
This patch adds it to Documentation/kernel-parameters.txt.

Signed-off-by: Christian Kujau <lists@nerdbynature.de>

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index cc85a92..5d0df23 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -2520,6 +2520,11 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			<port#>,<js1>,<js2>,<js3>,<js4>,<js5>,<js6>,<js7>
 			See also Documentation/input/joystick-parport.txt
 
+	udbg-immortal	[PPC] When debugging early kernel crashes that
+			happen after console_init() and before a proper 
+			console driver takes over, this boot options might
+			help "seeing" what's going on.
+
 	uhash_entries=	[KNL,NET]
 			Set number of hash buckets for UDP/UDP-Lite connections
 

Thanks,
Christian.
-- 
BOFH excuse #45:

virus attack, luser responsible
