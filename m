Return-Path: <jwboyer@gmail.com>
Received: from mail-iw0-f172.google.com (mail-iw0-f172.google.com
	[209.85.223.172]) by ozlabs.org (Postfix) with ESMTP id 4F251B7CF0
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  6 Feb 2010 00:42:45 +1100 (EST)
Received: by iwn2 with SMTP id 2so342665iwn.10
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 05 Feb 2010 05:42:43 -0800 (PST)
Date: Fri, 5 Feb 2010 08:42:36 -0500
From: Josh Boyer <jwboyer@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/4] Add ps3_storage module alias
Message-ID: <20100205134235.GG12001@hansolo.jdub.homelinux.org>
References: <20100205133552.GF12001@hansolo.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100205133552.GF12001@hansolo.jdub.homelinux.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This allows the upgrade path from older kernel releases to work
with the Fedora mkinitrd tool.

---

--- linux-2.6.22.ppc64/drivers/block/ps3disk.c~	2007-07-25 16:06:16.000000000 +0100
+++ linux-2.6.22.ppc64/drivers/block/ps3disk.c	2007-07-26 08:49:44.000000000 +0100
@@ -628,3 +628,4 @@ MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("PS3 Disk Storage Driver");
 MODULE_AUTHOR("Sony Corporation");
 MODULE_ALIAS(PS3_MODULE_ALIAS_STOR_DISK);
+MODULE_ALIAS("ps3_storage");
