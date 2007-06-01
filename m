Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AE50BDDF3F
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Jun 2007 17:47:45 +1000 (EST)
Subject: Re: [PATCH 1/1] Use NO_IRQ not IRQ_NONE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <526423a25b0e40c03678f4bb1d56e4b5719ab74d.1180682602.git.michael@ellerman.id.au>
References: <526423a25b0e40c03678f4bb1d56e4b5719ab74d.1180682602.git.michael@ellerman.id.au>
Content-Type: text/plain
Date: Fri, 01 Jun 2007 17:47:32 +1000
Message-Id: <1180684052.19517.422.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-06-01 at 17:23 +1000, Michael Ellerman wrote:
> There is a thinko in the irq code, it uses IRQ_NONE to indicate no irq,
> whereas it should be using NO_IRQ. IRQ_NONE is returned from irq handlers
> to say "not handled".
> 
> As it happens they currently have the same value (0), so this is just for
> future proof-ness.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

My fault actually :-) Mostly a typo, it's right elsewhere in the code
except in those 3 occurences. Brown paper bag time for me.

Cheers,
Ben.
