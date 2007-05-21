Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id CF170DDE21
	for <linuxppc-dev@ozlabs.org>; Mon, 21 May 2007 15:40:31 +1000 (EST)
Date: Mon, 21 May 2007 15:40:26 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] Comment out a currently unused function
Message-Id: <20070521154026.640320cd.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/macintosh/windfarm_smu_sat.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/drivers/macintosh/windfarm_smu_sat.c b/drivers/macintosh/windfarm_smu_sat.c
index 1043b39..42b767a 100644
--- a/drivers/macintosh/windfarm_smu_sat.c
+++ b/drivers/macintosh/windfarm_smu_sat.c
@@ -400,10 +400,12 @@ static int __init sat_sensors_init(void)
 	return i2c_add_driver(&wf_sat_driver);
 }
 
+#if 0	/* uncomment when module_exit() below is uncommented */
 static void __exit sat_sensors_exit(void)
 {
 	i2c_del_driver(&wf_sat_driver);
 }
+#endif
 
 module_init(sat_sensors_init);
 /*module_exit(sat_sensors_exit); Uncomment when cleanup is implemented */
-- 
1.5.1.4
