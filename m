Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C84F8DDEC2
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 08:27:19 +1100 (EST)
Subject: Re: [linux-pm] [PATCH 02/12] powermac: support G5 CPU hotplug
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
In-Reply-To: <20070214144556.GC25910@elf.ucw.cz>
References: <20070207124536.963531000@sipsolutions.net>
	<20070207124610.392302000@sipsolutions.net>
	<1170940494.4385.51.camel@johannes.berg>
	<20070214144556.GC25910@elf.ucw.cz>
Content-Type: text/plain
Date: Thu, 15 Feb 2007 08:27:09 +1100
Message-Id: <1171488429.20192.173.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Johannes Berg <johannes@sipsolutions.net>,
	linux-pm@lists.osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Can you disable timer interrupt on the interrupt controller, instead?
> Provides same functionality, and needs no runtime overhead...

On most PowerPCs, timer interrupt aren't an interrupt comimg from the
interrupt controller, but their own processor exception triggered by the
decrementer defined by the ppc architecture. 

Ben.
