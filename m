Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 119F5DDD0A
	for <linuxppc-dev@ozlabs.org>; Sun, 24 Feb 2008 09:08:51 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1NM8kXi002105
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 17:08:46 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1NM8kj4249524
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 17:08:46 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1NM8kU2026230
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 17:08:46 -0500
Received: from zod.rchland.ibm.com (wecm-9-67-149-29.wecm.ibm.com
	[9.67.149.29])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m1NM8kia026227
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 17:08:46 -0500
Date: Sat, 23 Feb 2008 16:08:13 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/3] [POWERPC] 4xx: Add support for AMCC 440EP Yosemite board
Message-ID: <20080223160813.2f8d282b@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This small series of patches adds support for the AMCC 440EP Yosemite
evaluation board.  This is the newer evaluation board for PowerPC 440EP
chips, replacing the older Bamboo board.

This is just the initial round of patches, but they are functional.
Also of note is that while all for on-board UARTs are enumerated in the
DTS file, only two of them are usable on the board.  The other two have
their "status" property set to disabled.  If used in conjunction with
the of_device_is_disabled patches I just sent out, then devices for
those won't be created.  This is not required.

josh
