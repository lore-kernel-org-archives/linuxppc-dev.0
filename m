Return-Path: <rpjday@crashcourse.ca>
Received: from astoria.ccjclearline.com (astoria.ccjclearline.com
	[64.235.106.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9CD74DDF1B
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Aug 2008 07:35:53 +1000 (EST)
Date: Wed, 6 Aug 2008 13:58:44 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: Linux PPC Mailing List <linuxppc-dev@ozlabs.org>
Subject: [PATCH] Delete completed "ppc removal" task from feature removal file.
Message-ID: <alpine.LFD.1.10.0808061357380.29692@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andrew Morton <akpm@osdl.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

  unless this is in someone's tree already.

diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
index c239554..17cab3c 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -205,19 +205,6 @@ Who:  Tejun Heo <htejun@gmail.com>

 ---------------------------

-What: The arch/ppc and include/asm-ppc directories
-When: Jun 2008
-Why:  The arch/powerpc tree is the merged architecture for ppc32 and ppc64
-      platforms.  Currently there are efforts underway to port the remaining
-      arch/ppc platforms to the merged tree.  New submissions to the arch/ppc
-      tree have been frozen with the 2.6.22 kernel release and that tree will
-      remain in bug-fix only mode until its scheduled removal.  Platforms
-      that are not ported by June 2008 will be removed due to the lack of an
-      interested maintainer.
-Who:  linuxppc-dev@ozlabs.org
-
----------------------------
-
 What:	i386/x86_64 bzImage symlinks
 When:	April 2010


========================================================================
Robert P. J. Day
Linux Consulting, Training and Annoying Kernel Pedantry:
    Have classroom, will lecture.

http://crashcourse.ca                          Waterloo, Ontario, CANADA
========================================================================
