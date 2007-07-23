Return-Path: <G.Chen@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D6B8ADDE36
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jul 2007 21:06:01 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l6NB5gl9008264
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jul 2007 04:05:43 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l6NB5fFd008974
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jul 2007 06:05:42 -0500 (CDT)
From: Chen Gong <g.chen@freescale.com>
To: paulus@samba.org, galak@kernel.crashing.org
Subject: [PATCH 0/3] Add virq mapping debugfs for PowerPC
Date: Mon, 23 Jul 2007 19:13:47 +0800
Message-Id: <11851892302391-git-send-email-g.chen@freescale.com>
Cc: linuxppc-dev@ozlabs.org, g.chen@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Cc: g.chen@freescale.com

Hi

These patches are the update as follows:
http://ozlabs.org/pipermail/linuxppc-dev/2007-March/033091.html
http://ozlabs.org/pipermail/linuxppc-dev/2007-March/033093.html
http://ozlabs.org/pipermail/linuxppc-dev/2007-March/033092.html
http://ozlabs.org/pipermail/linuxppc-dev/2007-March/033094.html

These patches are used for supplying virq mapping debugfs function.
It can be used for displaying irq-virq mapping relationship under debugfs.
Meanwhile, to express these information more clearly, we also add a new member
named "name" for struct irq_host.

[PATCH 1/3] Add a new member name to structure irq_host
[PATCH 2/3] Add irq host name for interrupt controllors
[PATCH 3/3] Add irq debugfs and virq mapping for getting the virq

Any feedback is welcome!

Best Regards,
Chen Gong
