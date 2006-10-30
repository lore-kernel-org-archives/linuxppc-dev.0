Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 8779267D32
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Oct 2006 03:49:03 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	k9UH2cQj017802
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Oct 2006 10:02:38 -0700 (MST)
Received: from ld0028-tx32 (ld0028-tx32.am.freescale.net [10.82.19.18])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with SMTP id k9UGn0ST004976
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Oct 2006 10:49:00 -0600 (CST)
Date: Mon, 30 Oct 2006 10:48:59 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: [DTC][PATCH] increment default output blob version from 3 to 16
Message-Id: <20061030104859.017cb613.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

increment default output blob version from 3 to 16

---
 dtc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/dtc.c b/dtc.c
index 646b814..3cb94e6 100644
--- a/dtc.c
+++ b/dtc.c
@@ -113,7 +113,7 @@ int main(int argc, char *argv[])
 	int opt;
 	FILE *inf = NULL;
 	FILE *outf = NULL;
-	int outversion = 3;
+	int outversion = 0x10;
 	int reservenum = 1;
 	int boot_cpuid_phys = 0xfeedbeef;
 
-- 
1.4.2.3
