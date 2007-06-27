Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E5834DDF04
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2007 23:49:39 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l5RDnZQw028354
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2007 09:49:35 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l5RDnZue254478
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2007 07:49:35 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l5RDnYQT031549
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2007 07:49:34 -0600
Subject: [PATCH] Schedule removal of arch/ppc
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org
Content-Type: text/plain
Date: Wed, 27 Jun 2007 08:49:33 -0500
Message-Id: <1182952173.9889.4.camel@weaponx.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The arch/ppc tree has been in a semi-nebulous "bug fix only" state for a
few kernel releases now.  The patch below officially declares this as of
the 2.6.22 kernel release and schedules arch/ppc for removal in June of
2008.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-
index 7d3f205..170a32e 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -348,3 +348,15 @@ Who:  Tejun Heo <htejun@gmail.com>
 
 ---------------------------
 
+What: The arch/ppc and include/asm-ppc directories
+When: Jun 2008
+Why:  The arch/powerpc tree is the merged architecture for ppc32 and ppc64
+      platforms.  Currently there are efforts underway to port the remaining
+      arch/ppc platforms the the merged tree.  New submissions to the arch/ppc
+      tree have been frozen with the 2.6.22 kernel release and that tree will
+      remain in bug-fix only mode until it's scheduled removal.  Platforms
+      that are not ported by June 2008 will be removed due to the lack of an
+      interested maintainer.
+Who:  linuxppc-dev@ozlabs.org
+
+---------------------------
