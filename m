Return-Path: <vbordug@ru.mvista.com>
Received: from localhost.localdomain (cdma-45-244.msk.skylink.ru
	[83.217.45.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A934467BA5
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Aug 2006 10:20:26 +1000 (EST)
From: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: [PATCH 0/6] POWERPC: Add support for CPM2 peripherals and 8560 eval
	board
Date: Sat, 12 Aug 2006 03:42:44 +0400
To: Paul Mackerras <paulus@samba.org>
Message-Id: <20060812000655.6186.42738.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following series implements the generic cpm2 infrastructure port,
mpc8560 board-specific bits, and an attempt to overhaul and get rid
of some stuff moved along from the 2.4 times.

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>

--
Sincerely, Vitaly
