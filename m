Return-Path: <olof@lixom.net>
Date: Wed, 12 Apr 2006 15:19:50 -0500
To: paulus@ozlabs.org
Subject: [1/10]: Quiet HVSI boot output
Message-ID: <20060412201950.GH19464@pb15.lixom.net>
References: <20060412201823.GG19464@pb15.lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060412201823.GG19464@pb15.lixom.net>
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org, hollisb@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There's no real need to print the number of found HVSI devices on the
console at every boot.

Signed-off-by: Olof Johansson <olof@lixom.net>

Index: 2.6/drivers/char/hvsi.c
===================================================================
--- 2.6.orig/drivers/char/hvsi.c
+++ 2.6/drivers/char/hvsi.c
@@ -1179,7 +1179,7 @@ static int __init hvsi_init(void)
 	if (tty_register_driver(hvsi_driver))
 		panic("Couldn't register hvsi console driver\n");
 
-	printk(KERN_INFO "HVSI: registered %i devices\n", hvsi_count);
+	printk(KERN_DEBUG "HVSI: registered %i devices\n", hvsi_count);
 
 	return 0;
 }
