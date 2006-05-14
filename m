Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 27C9A679E0
	for <linuxppc-dev@ozlabs.org>; Sun, 14 May 2006 20:12:52 +1000 (EST)
Received: from lyakh (helo=localhost)
	by poirot.grange with local-esmtp (Exim 3.36 #1 (Debian))
	id 1FfDam-00026v-00
	for <linuxppc-dev@ozlabs.org>; Sun, 14 May 2006 12:12:52 +0200
Date: Sun, 14 May 2006 12:12:52 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: linuxppc-dev@ozlabs.org
Subject: MPC10x UART datasheet?
Message-ID: <Pine.LNX.4.60.0605141206440.3640@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi

Could anyone, please, point me to a datasheet where the 2 UARTs are 
described, that are configured in arch/ppc/syslib/mpc10x_common.c at 
offsets 4500 and 4600? I looked through mpc107, mpc8240, mpc8250, mpc8260 
with little luck so far. They are not the ones referenced in mpc8260um as 
SCC / SMC thingies, are they?

Thanks
Guennadi
---
Guennadi Liakhovetski
