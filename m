Return-Path: <nikai@nikai.net>
Received: from webhosting01.bon.m2soft.com (webhosting01.bon.m2soft.com
	[195.38.20.32])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B8DBDB7043
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 23 Oct 2010 01:08:21 +1100 (EST)
Date: Fri, 22 Oct 2010 14:58:53 +0200
From: Nicolas Kaiser <nikai@nikai.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc/mv64x60: suspected typo in assignment
Message-ID: <20101022145853.7216c41f@absol.kitzblitz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Untested, but looks like an obvious typo to me.

Signed-off-by: Nicolas Kaiser <nikai@nikai.net>
---
 arch/powerpc/sysdev/mv64x60_dev.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/sysdev/mv64x60_dev.c b/arch/powerpc/sysdev/mv64x60_dev.c
index 1398bc4..a2c4999 100644
--- a/arch/powerpc/sysdev/mv64x60_dev.c
+++ b/arch/powerpc/sysdev/mv64x60_dev.c
@@ -345,7 +345,7 @@ static int __init mv64x60_i2c_device_setup(struct device_node *np, int id)
 	if (prop)
 		pdata.freq_m = *prop;
 
-	pdata.freq_m = 3;	/* default */
+	pdata.freq_n = 3;	/* default */
 	prop = of_get_property(np, "freq_n", NULL);
 	if (prop)
 		pdata.freq_n = *prop;
-- 
1.7.2.2
