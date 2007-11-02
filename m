Return-Path: <linas@austin.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 444DEDDE0D
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Nov 2007 07:26:01 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lA2KPu4K006706
	for <linuxppc-dev@ozlabs.org>; Fri, 2 Nov 2007 16:25:56 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	lA2KPuAe076744
	for <linuxppc-dev@ozlabs.org>; Fri, 2 Nov 2007 14:25:56 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lA2KPtnT012984
	for <linuxppc-dev@ozlabs.org>; Fri, 2 Nov 2007 14:25:55 -0600
Date: Fri, 2 Nov 2007 15:25:55 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 1/3] powerpc eeh: cleanup comments
Message-ID: <20071102202555.GA13828@austin.ibm.com>
References: <20071102201957.GU2183@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071102201957.GU2183@austin.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Clean up commentary, remove dead code.

Signed-off-by Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/platforms/pseries/eeh_driver.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

Index: linux-2.6.23-rc8-mm1/arch/powerpc/platforms/pseries/eeh_driver.c
===================================================================
--- linux-2.6.23-rc8-mm1.orig/arch/powerpc/platforms/pseries/eeh_driver.c	2007-10-16 11:39:18.000000000 -0500
+++ linux-2.6.23-rc8-mm1/arch/powerpc/platforms/pseries/eeh_driver.c	2007-10-16 11:46:30.000000000 -0500
@@ -113,9 +113,9 @@ static void eeh_report_error(struct pci_
 /**
  * eeh_report_mmio_enabled - tell drivers that MMIO has been enabled
  *
- * Report an EEH error to each device driver, collect up and
- * merge the device driver responses. Cumulative response
- * passed back in "userdata".
+ * Tells each device driver that IO ports, MMIO and config space I/O
+ * are now enabled. Collects up and merges the device driver responses.
+ * Cumulative response passed back in "userdata".
  */
 
 static void eeh_report_mmio_enabled(struct pci_dev *dev, void *userdata)
@@ -123,8 +123,6 @@ static void eeh_report_mmio_enabled(stru
 	enum pci_ers_result rc, *res = userdata;
 	struct pci_driver *driver = dev->driver;
 
-	// dev->error_state = pci_channel_mmio_enabled;
-
 	if (!driver ||
 	    !driver->err_handler ||
 	    !driver->err_handler->mmio_enabled)
