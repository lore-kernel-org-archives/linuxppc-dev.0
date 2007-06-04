Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C9326DDF69
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Jun 2007 15:27:28 +1000 (EST)
Subject: Re: [PATCH] [2.6.22] powerpc: uninline and export virq_to_hw()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20070604052707.GA27896@lixom.net>
References: <20070604044704.GA27581@lixom.net>
	<1180934410.31677.40.camel@localhost.localdomain>
	<20070604052707.GA27896@lixom.net>
Content-Type: text/plain
Date: Mon, 04 Jun 2007 15:27:21 +1000
Message-Id: <1180934841.31677.42.camel@localhost.localdomain>
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

On Mon, 2007-06-04 at 00:27 -0500, Olof Johansson wrote:
> 
> > It's called in fairly hot IRQ code path (the PIC themselves use it)
> no ?
> 
> I looked before I did the change. All of those open-code it.

Ah ok :-) Yeah, well, I remember open coding it when I wrote the PIC
code for virq's then somebody added virq_to_hw() :-)

Good to go then,

Cheers,
Ben.
