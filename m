Return-Path: <afleming@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id CB631DDDE6
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 13:42:49 +1100 (EST)
Date: Thu, 15 Feb 2007 20:42:03 -0600 (CST)
From: Andy Fleming <afleming@freescale.com>
To: linuxppc-dev@ozlabs.org, Kumar Gala <galak@kernel.crashing.org>
Subject: [RFC 0/7] Unite all PCI-e on 85xx and 86xx under one codebase
Message-ID: <Pine.LNX.4.61.0702152032280.9034@ld0175-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: jdl@jdl.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is the code we've been working on to clean up PCI-e support on 85xx 
and 86xx  We suspect that the code is not yet acceptable in this form, so 
we're soliciting comments.

You can also acquire all of this code by pulling the mpc85xx branch of

http://opensource.freescale.com/pub/scm/linux-2.6-85xx.git

The represent commits mpc85xx~18..mpc85xx~9 on that branch (At the moment)
