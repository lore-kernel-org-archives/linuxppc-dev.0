Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C381767CA5
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Nov 2006 11:43:17 +1100 (EST)
Subject: ppc32 PIO recovery mecanism
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>, Olaf Hering <olh@suse.de>
Content-Type: text/plain
Date: Mon, 06 Nov 2006 11:41:34 +1100
Message-Id: <1162773695.28571.260.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 32 bits powerpc, we currently have a mechanism where we try to
recover from machine checks happening on PIO operations (inb/outb/....).
This mecanisms has proven of dubious reliability in the past and it's my
understanding that we've pretty fixed all relevant legacy drivers that
distro typically load so that they don't muck around when they
shouldn't.

I'm currently merging 32 and 64 bits io.h and I would really like to
just get rid of that stuff, but I'd like your distro point of view
first. Is this mechanism still useful at all or not ?

Cheers,
Ben.
