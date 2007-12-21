Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A2244DDFF8
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Dec 2007 08:22:05 +1100 (EST)
Subject: Re: [PATCH 3/4] PowerPC: Add PCI entry to 440EPx Sequoia DTS.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Valentine Barshak <vbarshak@ru.mvista.com>
In-Reply-To: <20071221162601.GA1700@ru.mvista.com>
References: <20071221162601.GA1700@ru.mvista.com>
Content-Type: text/plain
Date: Sat, 22 Dec 2007 08:21:25 +1100
Message-Id: <1198272085.6737.6.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2007-12-21 at 19:26 +0300, Valentine Barshak wrote:
> +
> +                       /* All PCI interrupts are routed to IRQ 67 */
> +                       interrupt-map-mask = <0000 0 0 0>;
> +                       interrupt-map = < 0000 0 0 0 &UIC2 3 8 >;
> +               };
>         };

Wow, all 4 lines of all slots ?

Ben.
