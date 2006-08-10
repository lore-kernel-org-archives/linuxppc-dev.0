Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3220F67B52
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Aug 2006 18:18:56 +1000 (EST)
Subject: Re: [PATCH][2/2] RTAS MSI
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1155197015.9801.82.camel@localhost.localdomain>
References: <1154024154.29826.229.camel@goblue>
	<1154024834.29826.240.camel@goblue>
	<1154320382.19883.26.camel@localhost.localdomain>
	<1154379714.29826.396.camel@goblue>
	<1154509462.26242.9.camel@localhost.localdomain>
	<1155117003.4040.69.camel@localhost.localdomain>
	<1155197015.9801.82.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 10 Aug 2006 10:18:35 +0200
Message-Id: <1155197915.17187.126.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, PaulMackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-08-10 at 18:03 +1000, Michael Ellerman wrote:

> OK, will fix it. In the long run we probably want a function that takes
> any dn and finds the host for it.

That's what the OF irq parsing functions do...  You can't just walk up
the device-tree for interrupts, you have to walk up the interrupt
tree...

> Err, great. Anymore info? I'll just set it to EDGE for now.

Or just don't call set_irq_type()... xics doesn't care.

Ben.
