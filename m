Return-Path: <adobriyan@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.172])
	by ozlabs.org (Postfix) with ESMTP id 377B967BE2
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Aug 2006 09:22:42 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id e2so1778751ugf
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Aug 2006 16:22:41 -0700 (PDT)
Date: Tue, 22 Aug 2006 03:22:23 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] windfarm_smu_sat.c: simplify around i2c_add_driver()
Message-ID: <20060821232223.GB5220@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/macintosh/windfarm_smu_sat.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

--- a/drivers/macintosh/windfarm_smu_sat.c
+++ b/drivers/macintosh/windfarm_smu_sat.c
@@ -397,12 +397,7 @@ static int wf_sat_detach(struct i2c_clie
 
 static int __init sat_sensors_init(void)
 {
-	int err;
-
-	err = i2c_add_driver(&wf_sat_driver);
-	if (err < 0)
-		return err;
-	return 0;
+	return i2c_add_driver(&wf_sat_driver);
 }
 
 static void __exit sat_sensors_exit(void)
