Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5118A2BEA0
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Nov 2004 09:11:02 +1100 (EST)
Received: from gaston (localhost [127.0.0.1])
	by gate.crashing.org (8.12.8/8.12.8) with ESMTP id iAJM85gJ002861
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Nov 2004 16:08:06 -0600
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Sat, 20 Nov 2004 09:10:53 +1100
Message-Id: <1100902253.3856.16.camel@gaston>
Mime-Version: 1.0
Subject: Re: TEST: Sleep suppport for iBook G4 & Aluminium PowerBooks (ATI
	based)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> So here's the new patch, it replaces the previous one for Aluminium
> PowerBooks, and is still against 2.6.9. I'll do something against 2.6.10
> when that one is out (it's a bit late to get that merged with Linus,
> 2.6.10 is in freeze mode now) and I hope to get all of that in 2.6.11.
>
> .../...

Ok, I already found a bug, occasional lockups on boot and when setting
the backlight. I uploaded a new version at:

http://gate.crashing.org/~benh/albook-ibookg4-sleep-2.diff

Ben.
