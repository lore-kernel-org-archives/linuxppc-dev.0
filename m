Return-Path: <olh@suse.de>
Received: from mx1.suse.de (mail.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E02EC684C5
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Oct 2005 06:11:22 +1000 (EST)
Date: Mon, 10 Oct 2005 22:11:17 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org
Message-ID: <20051010201117.GB14317@suse.de>
References: <20051010200739.GA14317@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20051010200739.GA14317@suse.de>
Subject: [PATCH] Add modalias for pmac network drivers
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


mesh, mac53c94 and airport already have an entry.
Add the network drivers for pmac.

Signed-off-by: Olaf Hering <olh@suse.de>

 drivers/net/bmac.c                   |    1 +
 drivers/net/mace.c                   |    1 +

Index: linux-2.6.12/drivers/net/bmac.c
===================================================================
--- linux-2.6.12.orig/drivers/net/bmac.c
+++ linux-2.6.12/drivers/net/bmac.c
@@ -1658,6 +1658,7 @@ static struct of_device_id bmac_match[] 
 	},
 	{},
 };
+MODULE_DEVICE_TABLE (of, bmac_match);
 
 static struct macio_driver bmac_driver = 
 {
Index: linux-2.6.12/drivers/net/mace.c
===================================================================
--- linux-2.6.12.orig/drivers/net/mace.c
+++ linux-2.6.12/drivers/net/mace.c
@@ -1016,6 +1016,7 @@ static struct of_device_id mace_match[] 
 	},
 	{},
 };
+MODULE_DEVICE_TABLE (of, mace_match);
 
 static struct macio_driver mace_driver = 
 {

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
