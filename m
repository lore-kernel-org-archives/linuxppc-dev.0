Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 48159DDE1B
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Mar 2008 14:42:13 +1100 (EST)
From: Segher Boessenkool <segher@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Correct a terrible scheduling error
Date: Tue,  4 Mar 2008 04:42:07 +0100
Message-Id: <d1f2621db926ece5ec9ec0baf8a70ec8e2d72b10.1204601394.git.segher@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It would be a pity if we can't all enjoy this.

Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>
---
 Documentation/feature-removal-schedule.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
index c1d1fd0..78021bf 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -201,13 +201,13 @@ Who:  Tejun Heo <htejun@gmail.com>
 ---------------------------
 
 What: The arch/ppc and include/asm-ppc directories
-When: Jun 2008
+When: end of July 2008
 Why:  The arch/powerpc tree is the merged architecture for ppc32 and ppc64
       platforms.  Currently there are efforts underway to port the remaining
       arch/ppc platforms to the merged tree.  New submissions to the arch/ppc
       tree have been frozen with the 2.6.22 kernel release and that tree will
       remain in bug-fix only mode until its scheduled removal.  Platforms
-      that are not ported by June 2008 will be removed due to the lack of an
+      that are not ported by July 2008 will be removed due to the lack of an
       interested maintainer.
 Who:  linuxppc-dev@ozlabs.org
 
-- 
1.5.3.4.208.g805a
