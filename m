Return-Path: <nfont@austin.ibm.com>
Message-ID: <4B06B119.1080402@austin.ibm.com>
Date: Fri, 20 Nov 2009 09:09:13 -0600
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org,
	microblaze-uclinux@itee.uq.edu.au
Subject: [PATCH 4/4 v2] Include of_dynamic.h in pseries/reconfig.c
References: <4B06AF33.1000400@austin.ibm.com>
In-Reply-To: <4B06AF33.1000400@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Include the newly created linux/of_dynamic.h to pick up the 
of_[attach,detach]_node declarations.

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>

---
 arch/powerpc/platforms/pseries/reconfig.c |    1 +
 1 file changed, 1 insertion(+)

Index: test-devicetree/arch/powerpc/platforms/pseries/reconfig.c
===================================================================
--- test-devicetree.orig/arch/powerpc/platforms/pseries/reconfig.c	2009-11-20 11:59:00.000000000 -0600
+++ test-devicetree/arch/powerpc/platforms/pseries/reconfig.c	2009-11-20 12:37:32.000000000 -0600
@@ -15,6 +15,7 @@
 #include <linux/kref.h>
 #include <linux/notifier.h>
 #include <linux/proc_fs.h>
+#include <linux/of_dynamic.h>
 
 #include <asm/prom.h>
 #include <asm/machdep.h>
