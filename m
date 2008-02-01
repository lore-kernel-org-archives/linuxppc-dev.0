Return-Path: <bastian@waldi.eu.org>
Received: from wavehammer.waldi.eu.org (wavehammer.waldi.eu.org
	[82.139.201.20]) by ozlabs.org (Postfix) with ESMTP id B5B86DDFDE
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Feb 2008 07:16:17 +1100 (EST)
Date: Fri, 1 Feb 2008 21:16:15 +0100
From: Bastian Blank <bastian@waldi.eu.org>
To: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org
Subject: [PATCH] Remove old definition of setup_per_cpu_areas
Message-ID: <20080201201615.GA29187@wavehammer.waldi.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Remove old definition of setup_per_cpu_areas.

The definition is done depending on the new config variable
HAVE_SETUP_PER_CPU_AREA. 

Signed-off-by: Bastian Blank <waldi@debian.org>

diff --git a/include/asm-powerpc/percpu.h b/include/asm-powerpc/percpu.h
index cc1cbf6..f309d34 100644
--- a/include/asm-powerpc/percpu.h
+++ b/include/asm-powerpc/percpu.h
@@ -30,8 +30,6 @@ do {								\
 		       (src), (size));				\
 } while (0)
 
-extern void setup_per_cpu_areas(void);
-
 #else /* ! SMP */
 
 #define per_cpu(var, cpu)			(*((void)(cpu), &per_cpu__##var))
