Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CC304DDF10
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jul 2007 23:25:50 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l63DPlxA014566
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Jul 2007 09:25:47 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l63DPlaE262526
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Jul 2007 07:25:47 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l63DPlCd030814
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Jul 2007 07:25:47 -0600
Subject: [PATCH v2] Schedule removal of arch/ppc
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org
Content-Type: text/plain
Date: Tue, 03 Jul 2007 08:25:46 -0500
Message-Id: <1183469146.3590.7.camel@weaponx.rchland.ibm.com>
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

---
 Documentation/feature-removal-schedule.txt |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- linux-2.6.orig/Documentation/feature-removal-schedule.txt
+++ linux-2.6/Documentation/feature-removal-schedule.txt
@@ -348,3 +348,15 @@ Who:  Tejun Heo <htejun@gmail.com>
 
 ---------------------------
 
+What: The arch/ppc and include/asm-ppc directories
+When: Jun 2008
+Why:  The arch/powerpc tree is the merged architecture for ppc32 and ppc64
+      platforms.  Currently there are efforts underway to port the remaining
+      arch/ppc platforms to the merged tree.  New submissions to the arch/ppc
+      tree have been frozen with the 2.6.22 kernel release and that tree will
+      remain in bug-fix only mode until its scheduled removal.  Platforms
+      that are not ported by June 2008 will be removed due to the lack of an
+      interested maintainer.
+Who:  linuxppc-dev@ozlabs.org
+
+---------------------------
