Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 65089DDE2E
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jan 2007 14:17:32 +1100 (EST)
Subject: Re: [PATCH] powerpc: Fix irq routing on some PowerMac 32 bits
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
In-Reply-To: <1168398002.571.3.camel@localhost.localdomain>
References: <1165806548.7260.0.camel@localhost.localdomain>
	<1168398002.571.3.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 10 Jan 2007 14:16:52 +1100
Message-Id: <1168399012.22458.328.camel@localhost.localdomain>
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

On Wed, 2007-01-10 at 11:00 +0800, Zang Roy-r61911 wrote:
> Ben,
> 	After apply your patch, my 8548CDS board blocked when booting up.
> 	Should I adjust my flat device tree or bug introduced by this patch?
> 	Thanks.
> Roy

Well, it would be useful to track down what's wrong... I suspect it
might be triggering a problem with your device-tree but it's difficult
to say at this point.

Ben.
