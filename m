Return-Path: <akpm@osdl.org>
Message-Id: <200510290046.j9T0kp7R030020@shell0.pdx.osdl.net>
To: paulus@samba.org
From: akpm@osdl.org
Date: Fri, 28 Oct 2005 17:46:21 -0700
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, olh@suse.de,
	linuxppc64-dev@ozlabs.org
Subject: [patch 11/43] Add modalias for pmac network drivers
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


From: Olaf Hering <olh@suse.de>

mesh, mac53c94 and airport already have an entry.  Add the network drivers
for pmac.

Signed-off-by: Olaf Hering <olh@suse.de>
Cc: Paul Mackerras <paulus@samba.org>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/net/bmac.c |    1 +
 drivers/net/mace.c |    1 +
 2 files changed, 2 insertions(+)

diff -puN drivers/net/bmac.c~add-modalias-for-pmac-network-drivers drivers/net/bmac.c
--- devel/drivers/net/bmac.c~add-modalias-for-pmac-network-drivers	2005-10-28 17:44:03.000000000 -0700
+++ devel-akpm/drivers/net/bmac.c	2005-10-28 17:44:03.000000000 -0700
@@ -1658,6 +1658,7 @@ static struct of_device_id bmac_match[] 
 	},
 	{},
 };
+MODULE_DEVICE_TABLE (of, bmac_match);
 
 static struct macio_driver bmac_driver = 
 {
diff -puN drivers/net/mace.c~add-modalias-for-pmac-network-drivers drivers/net/mace.c
--- devel/drivers/net/mace.c~add-modalias-for-pmac-network-drivers	2005-10-28 17:44:03.000000000 -0700
+++ devel-akpm/drivers/net/mace.c	2005-10-28 17:44:03.000000000 -0700
@@ -1016,6 +1016,7 @@ static struct of_device_id mace_match[] 
 	},
 	{},
 };
+MODULE_DEVICE_TABLE (of, mace_match);
 
 static struct macio_driver mace_driver = 
 {
_
