Return-Path: <vanbaren@cideas.com>
Received: from sccrmhc14.comcast.net (sccrmhc14.comcast.net [63.240.77.84])
	by ozlabs.org (Postfix) with ESMTP id 0C4A2DDE28
	for <linuxppc-dev@ozlabs.org>; Sun, 15 Apr 2007 08:25:08 +1000 (EST)
Date: Sat, 14 Apr 2007 18:16:47 -0400
From: Jerry Van Baren <gvb.uboot@gmail.com>
To: linuxppc-dev@ozlabs.org, jdl@jdl.com
Subject: [PATCH dtc] Add -o <output file> to the usage message.
Message-ID: <20070414221647.GB23870@dellserver.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Gerald Van Baren <vanbaren@cideas.com>
---

Hi Jon,

It turns out -o <file> was there all along, just not in the usage. :-)

(Jon: sorry for the dup, I messed up the linuxppc-dev@ozlabs.org address
the first time).

Best regards,
gvb


 dtc.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/dtc.c b/dtc.c
index a94a402..5767834 100644
--- a/dtc.c
+++ b/dtc.c
@@ -83,6 +83,7 @@ static void usage(void)
 	fprintf(stderr, "\t\t\tdts - device tree source text\n");
 	fprintf(stderr, "\t\t\tdtb - device tree blob\n");
 	fprintf(stderr, "\t\t\tfs - /proc/device-tree style directory\n");
+	fprintf(stderr, "\t-o <output file>\n");
 	fprintf(stderr, "\t-O <output format>\n");
 	fprintf(stderr, "\t\tOutput formats are:\n");
 	fprintf(stderr, "\t\t\tdts - device tree source text\n");
-- 
1.4.4.4
