Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2D5E2DDE2C
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jan 2007 14:58:16 +1100 (EST)
Subject: Re: [PATCH] powerpc: Fix irq routing on some PowerMac 32 bits
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
In-Reply-To: <1168400086.700.12.camel@localhost.localdomain>
References: <1165806548.7260.0.camel@localhost.localdomain>
	<1168398002.571.3.camel@localhost.localdomain>
	<1168399012.22458.328.camel@localhost.localdomain>
	<1168400086.700.12.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 10 Jan 2007 14:58:09 +1100
Message-Id: <1168401489.22458.332.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Stop here.

Probably the log is just the last console output you got from the early
console before it switched to the main one. Do you use udbg on these
boards for early boot messages ? If yes, have you tried the
udbg-immortal option ? (Or just prevent udbg from unregistering).

Do you have access to a HW debugging tool maybe to trace what's going
on ?

I have no idea what's wrong at this point, though it's likely to be a
problem with your device-tree, I can't verify it without a bit more
debug data. Have you tried adding some debug infos to the new
implementation of pci_device_to_OF_node(), check how it's called and
what it returns ? That might give you a clue about the problem.

Ben.
