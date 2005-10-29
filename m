Return-Path: <wd@denx.de>
Received: from mailout05.sul.t-online.com (mailout05.sul.t-online.com
	[194.25.134.82]) by ozlabs.org (Postfix) with ESMTP id 108246861A
	for <linuxppc-dev@ozlabs.org>; Sun, 30 Oct 2005 07:40:43 +1100 (EST)
To: Andy Fleming <afleming@freescale.com>,
	Jeff Garzik <jgarzik@pobox.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Date: Sat, 29 Oct 2005 22:40:32 +0200
Sender: wd@denx.de
Message-Id: <20051029204032.BA111353A42@atlas.denx.de>
Cc: linuxppc-dev@ozlabs.org
Subject: use of phy_connect() in drivers/net/gianfar.c ?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

this commit in the 2.6.14 tree is breaking drivers/net/gianfar.c  for
me:

	Commit: bb40dcbb0fcebe1df08ba261483fcc38b307d063
	Author: Andy Fleming <afleming@freescale.com>  2005-09-24 04:54:21
	Committer: Jeff Garzik <jgarzik@pobox.com>  2005-09-24 04:54:21
	Parent: acc4b985a6f8f22a0e826692894a4af234764001 ([PATCH] orinoco: Bump version to 0.15rc3.)
	Child:  8cee0cd5bec53b78dd3c43a73b27821a688133e6 ([netdrvr] delete CONFIG_PHYCONTROL)

	    [netdrvr gianfar] use new phy layer
	        
	    Signed-off-by: Andy Fleming <afleming@freescale.com>
	    Signed-off-by: Jeff Garzik <jgarzik@pobox.com>

I get:

drivers/net/gianfar.c: In function `init_phy':
drivers/net/gianfar.c:410: error: structure has no member named `bus_id'


Am I missing something?

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
In C we had to code our own bugs, in C++ we can inherit them.
