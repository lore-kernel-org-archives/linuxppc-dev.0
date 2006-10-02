Return-Path: <hnguyen@de.ibm.com>
Received: from mtagate3.de.ibm.com (mtagate3.de.ibm.com [195.212.29.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A4EEC67BED
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Oct 2006 06:37:31 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.13.8/8.13.8) with ESMTP id k92KbJdO068888
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Oct 2006 20:37:19 GMT
Received: from d12av01.megacenter.de.ibm.com (d12av01.megacenter.de.ibm.com
	[9.149.165.212])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id k92KdQRf3211506
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Oct 2006 22:39:26 +0200
Received: from d12av01.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av01.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id k92KbJFH028483
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Oct 2006 22:37:19 +0200
From: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
To: rolandd@cisco.com
Subject: [PATCH 2.6.19-rc1 2/2] ehca: improved ehca debug format
Date: Mon, 2 Oct 2006 22:33:50 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ueXIFIJcvA+6/M1"
Message-Id: <200610022233.50497.hnguyen@de.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	openib-general@openib.org, openfabrics-ewg@openib.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Boundary-00=_ueXIFIJcvA+6/M1
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,
here is the 2nd patch of ehca with a small format improvement in ehca debug function.
Thanks!
Nam Nguyen


Signed-off-by: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
---


 ehca_tools.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


diff -Nurp infiniband_orig/drivers/infiniband/hw/ehca/ehca_tools.h infiniband_work/drivers/infiniband/hw/ehca/ehca_tools.h
--- infiniband_orig/drivers/infiniband/hw/ehca/ehca_tools.h 2006-10-02 22:08:57.000000000 +0200
+++ infiniband_work/drivers/infiniband/hw/ehca/ehca_tools.h 2006-10-02 18:29:53.000000000 +0200
@@ -117,7 +117,7 @@ extern int ehca_debug_level;
   unsigned int l = (unsigned int)(len); \
   unsigned char *deb = (unsigned char*)(adr); \
   for (x = 0; x < l; x += 16) { \
-   printk("EHCA_DMP:%s" format \
+   printk("EHCA_DMP:%s " format \
           " adr=%p ofs=%04x %016lx %016lx\n", \
           __FUNCTION__, ##args, deb, x, \
           *((u64 *)&deb[0]), *((u64 *)&deb[8])); \

--Boundary-00=_ueXIFIJcvA+6/M1
Content-Type: text/x-diff;
  charset="us-ascii";
  name="svnehca_0017_roland_git.patch2"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="svnehca_0017_roland_git.patch2"

diff -Nurp infiniband_orig/drivers/infiniband/hw/ehca/ehca_tools.h infiniband_work/drivers/infiniband/hw/ehca/ehca_tools.h
--- infiniband_orig/drivers/infiniband/hw/ehca/ehca_tools.h	2006-10-02 22:08:57.000000000 +0200
+++ infiniband_work/drivers/infiniband/hw/ehca/ehca_tools.h	2006-10-02 18:29:53.000000000 +0200
@@ -117,7 +117,7 @@ extern int ehca_debug_level;
 		unsigned int l = (unsigned int)(len); \
 		unsigned char *deb = (unsigned char*)(adr);	\
 		for (x = 0; x < l; x += 16) { \
-			printk("EHCA_DMP:%s" format \
+			printk("EHCA_DMP:%s " format \
 			       " adr=%p ofs=%04x %016lx %016lx\n", \
 			       __FUNCTION__, ##args, deb, x, \
 			       *((u64 *)&deb[0]), *((u64 *)&deb[8])); \

--Boundary-00=_ueXIFIJcvA+6/M1--
