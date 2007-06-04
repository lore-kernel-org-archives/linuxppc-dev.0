Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id B79A6DE063
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Jun 2007 15:21:03 +1000 (EST)
Date: Mon, 4 Jun 2007 00:27:07 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] [2.6.22] powerpc: uninline and export virq_to_hw()
Message-ID: <20070604052707.GA27896@lixom.net>
References: <20070604044704.GA27581@lixom.net>
	<1180934410.31677.40.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1180934410.31677.40.camel@localhost.localdomain>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jun 04, 2007 at 03:20:10PM +1000, Benjamin Herrenschmidt wrote:
> On Sun, 2007-06-03 at 23:47 -0500, Olof Johansson wrote:
> > Uninline virq_to_hw and export it so modules can use it. The
> > alternative
> > would be to export the irq_map array instead, but it's an infrequently
> > called function, and keeping the array unexported seems considerably
> > cleaner.
> 
> It's called in fairly hot IRQ code path (the PIC themselves use it) no ?

I looked before I did the change. All of those open-code it.


-Olof
