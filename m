Return-Path: <vbordug@ru.mvista.com>
Received: from localhost.localdomain (cdma-40-144.msk.skylink.ru
	[83.217.40.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 234B867DF5
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Nov 2006 12:59:43 +1100 (EST)
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 0/5][RFC][POWERPC] 8xx: Add support for FSL 8xx and 885add
	eval board
Date: Tue, 14 Nov 2006 03:27:33 +0300
Message-Id: <20061114002733.15791.97175.stgit@localhost.localdomain>
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

The following series intended to port the 8xx boards support to arch/powerpc
together with mpc885ads reference board. It features regression-less transaction
(all the peripherials work, namely SMC1,2 UARTs, FEC1,2 or SCC3 Ethernet.

The Documentation stuff definitely needs to be re-synced with this SoC details,
but the entire stuff may be useful as it is now, and I'm expecting some feedback 
meanwhile.

--
Sincerely, Vitaly
