Return-Path: <glikely@secretlab.ca>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.171])
	by ozlabs.org (Postfix) with ESMTP id A0055DE011
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jul 2008 08:39:48 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so4058992wfg.15
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jul 2008 15:39:47 -0700 (PDT)
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] powerpc: Modify MPC52xx maintainers entry to cover all
	MPC5xxx parts
To: benh@kernel.crashing.org, jrigby@freescale.com, tnt@246tnt.com,
	linuxppc-dev@ozlabs.org
Date: Fri, 11 Jul 2008 16:39:44 -0600
Message-ID: <20080711223944.22439.37831.stgit@trillian.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: Grant Likely <glikely@secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Linux now supports the MPC5121 part and is handled by the same
maintainer.  Update MAINTAINERS to reflect this.  Also remove URLs
which do not work or contain out of date information.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 MAINTAINERS |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8f0ec46..c984014 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2489,13 +2489,11 @@ W:	http://www.penguinppc.org/
 L:	linuxppc-dev@ozlabs.org
 S:	Maintained
 
-LINUX FOR POWERPC EMBEDDED MPC52XX
+LINUX FOR POWERPC EMBEDDED MPC5XXX
 P:	Sylvain Munaut
 M:	tnt@246tNt.com
 P:	Grant Likely
 M:	grant.likely@secretlab.ca
-W:	http://www.246tNt.com/mpc52xx/
-W:	http://www.penguinppc.org/
 L:	linuxppc-dev@ozlabs.org
 S:	Maintained
 
