Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.234])
	by ozlabs.org (Postfix) with ESMTP id D850FDDDA2
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Apr 2009 02:50:19 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f9so481050rvb.9
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 09:50:18 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] powerpc: Update MPC5xxx and Xilinx Virtex maintainer entries
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, tnt@246tNt.com
Date: Tue, 28 Apr 2009 10:50:15 -0600
Message-ID: <20090428165015.1410.47926.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

- Add git tree URLs
- Drop Sylvain from the 5xxx maintainers list.  He hasn't been active
  for a while now.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 MAINTAINERS |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff --git a/MAINTAINERS b/MAINTAINERS
index ef03abe..4a8d367 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3434,11 +3434,10 @@ L:	linuxppc-dev@ozlabs.org
 S:	Maintained
 
 LINUX FOR POWERPC EMBEDDED MPC5XXX
-P:	Sylvain Munaut
-M:	tnt@246tNt.com
 P:	Grant Likely
 M:	grant.likely@secretlab.ca
 L:	linuxppc-dev@ozlabs.org
+T:	git git://git.secretlab.ca/git/linux-2.6.git
 S:	Maintained
 
 LINUX FOR POWERPC EMBEDDED PPC4XX
@@ -3456,6 +3455,7 @@ P:	Grant Likely
 M:	grant.likely@secretlab.ca
 W:	http://wiki.secretlab.ca/index.php/Linux_on_Xilinx_Virtex
 L:	linuxppc-dev@ozlabs.org
+T:	git git://git.secretlab.ca/git/linux-2.6.git
 S:	Maintained
 
 LINUX FOR POWERPC EMBEDDED PPC8XX
