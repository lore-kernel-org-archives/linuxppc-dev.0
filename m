Return-Path: <ericvh@gmail.com>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 34312B6F68
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 07:25:12 +1000 (EST)
Received: by gxk1 with SMTP id 1so778103gxk.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 18 May 2011 14:25:07 -0700 (PDT)
From: Eric Van Hensbergen <ericvh@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] [RFC] Mainline BG/P platform support
Date: Wed, 18 May 2011 16:24:49 -0500
Message-Id: <1305753895-24845-1-git-send-email-ericvh@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, bg-linux@lists.anl-external.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The Linux kernel patches for the IBM BlueGene/P have been open-sourced
for quite some time, but haven't been integrated into the mainline Linux
kernel source tree.  This is the first patch series of several where I
will attempt to cleanup and mainline the already public patches.  I
welcome feedback as well as any help I can get.  I'm drawing on
the patches available for the IBM Compute Node kernel, the ZeptoOS project
and the Kittyhawk project.
(all available from http://wiki.bg.anl-external.org)

I'll be prioritizing core patches which are harder to keep current with
mainline due to merge conflicts and then slowly incorporating the drivers
and other extensions (if acceptable after community review).

I'll be maintaining the patchset in my kernel.org repository
(/pub/scm/linux/kernel/git/ericvh/bluegene.git) under the bluegene
branch with the source repos (zepto, kittyhawk, ibmcn) available in
respective branches.  Ben - if you would prefer me to send pull requests
once we get rolling, I can switch to that -- otherwise I'll stick to
just submitting patches to the list assuming you'll pull them when they
become acceptable.  Thanks for your attention reviewing these patches.

Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>
---
 MAINTAINERS |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 69f19f1..3ffca88 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3863,6 +3863,14 @@ S:	Maintained
 F:	arch/powerpc/platforms/40x/
 F:	arch/powerpc/platforms/44x/
 
+LINUX FOR POWERPC BLUEGENE/P
+M:	Eric Van Hensbergen <ericvh@gmail.com>
+W:	http://bg-linux.anl-external.org/wiki/index.php/Main_Page
+L:	bg-linux@lists.anl-external.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/bluegene.git
+S:	Maintained
+F:	arch/powerpc/platforms/44x/bgp*
+
 LINUX FOR POWERPC EMBEDDED XILINX VIRTEX
 M:	Grant Likely <grant.likely@secretlab.ca>
 W:	http://wiki.secretlab.ca/index.php/Linux_on_Xilinx_Virtex
-- 
1.7.4.1
