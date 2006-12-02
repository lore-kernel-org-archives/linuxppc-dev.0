Return-Path: <grant.likely@secretlab.ca>
Received: from sandbox.secretlab.ca (S01060016b61d1226.cg.shawcable.net
	[68.147.191.145]) by ozlabs.org (Postfix) with ESMTP id E962867BD4
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Dec 2006 19:45:59 +1100 (EST)
From: Grant Likely <grant.likely@secretlab.ca>
To: David Gibson <david@gibson.dropbear.id.au>,
	linuxppc-dev@ozlabs.org
Subject: [LIBFDT] Add .dtb files to .gitignore
Date: Sat,  2 Dec 2006 01:45:41 -0700
Message-Id: <1165049149754-git-send-email-grant.likely@secretlab.ca>
In-Reply-To: <11650491414017-git-send-email-grant.likely@secretlab.ca>
References: <11650491414017-git-send-email-grant.likely@secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
 .gitignore |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index 4b147f1..42b3e35 100644
--- a/.gitignore
+++ b/.gitignore
@@ -3,3 +3,4 @@
 *.a
 *.so
 *~
+tests/*.dtb
-- 
1.4.3.rc2.g0503
