Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18781.39639.123017.149165@cargo.ozlabs.ibm.com>
Date: Fri, 2 Jan 2009 15:40:55 +1100
From: Paul Mackerras <paulus@samba.org>
To: torvalds@linux-foundation.org
Subject: [PATCH v2] Update powerpc maintainers
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ben Herrenschmidt is taking over as the primary powerpc architecture
maintainer.  I'll still be around as his backup/deputy.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
Now with added tree location update goodness!

diff --git a/MAINTAINERS b/MAINTAINERS
index ceb32ee..967b0e8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2635,13 +2635,13 @@ W:	http://www.hansenpartnership.com/voyager
 S:	Maintained
 
 LINUX FOR POWERPC (32-BIT AND 64-BIT)
-P:	Paul Mackerras
-M:	paulus@samba.org
 P:	Benjamin Herrenschmidt
 M:	benh@kernel.crashing.org
+P:	Paul Mackerras
+M:	paulus@samba.org
 W:	http://www.penguinppc.org/
 L:	linuxppc-dev@ozlabs.org
-T:	git kernel.org:/pub/scm/linux/kernel/git/paulus/powerpc.git
+T:	git kernel.org:/pub/scm/linux/kernel/git/benh/powerpc.git
 S:	Supported
 
 LINUX FOR POWER MACINTOSH
