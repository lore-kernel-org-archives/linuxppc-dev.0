Return-Path: <olof@lixom.net>
Date: Thu, 29 May 2008 15:05:44 -0500
From: Olof Johansson <olof@lixom.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2.6.26] electra_cf: Add MODULE_DEVICE_TABLE()
Message-ID: <20080529200542.GA20002@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: pasemi-linux@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

electra_cf: Add MODULE_DEVICE_TABLE()
    
Add a module device table to electra_cf so that modules can be
auto-probed/loaded.
    
[will be included in git pull request later today]

diff --git a/drivers/pcmcia/electra_cf.c b/drivers/pcmcia/electra_cf.c
index 0a6cea1..52d0aa8 100644
--- a/drivers/pcmcia/electra_cf.c
+++ b/drivers/pcmcia/electra_cf.c
@@ -352,6 +352,7 @@ static struct of_device_id electra_cf_match[] = {
 	},
 	{},
 };
+MODULE_DEVICE_TABLE(of, electra_cf_match);
 
 static struct of_platform_driver electra_cf_driver = {
 	.name	   = (char *)driver_name,
