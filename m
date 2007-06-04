Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7F1A6E04A1
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Jun 2007 15:20:22 +1000 (EST)
Subject: Re: [PATCH] [2.6.22] powerpc: uninline and export virq_to_hw()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20070604044704.GA27581@lixom.net>
References: <20070604044704.GA27581@lixom.net>
Content-Type: text/plain
Date: Mon, 04 Jun 2007 15:20:10 +1000
Message-Id: <1180934410.31677.40.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2007-06-03 at 23:47 -0500, Olof Johansson wrote:
> Uninline virq_to_hw and export it so modules can use it. The
> alternative
> would be to export the irq_map array instead, but it's an infrequently
> called function, and keeping the array unexported seems considerably
> cleaner.

It's called in fairly hot IRQ code path (the PIC themselves use it) no ?

Ben.
