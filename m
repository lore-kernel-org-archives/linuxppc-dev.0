Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 31939DE1E0
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Jan 2007 07:50:27 +1100 (EST)
Subject: Re: [RFC/PATCH 14/16] MPIC MSI backend
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <m1ejpiw9s8.fsf@ebiederm.dsl.xmission.com>
References: <1169714047.65693.647693675533.qpush@cradle>
	<20070125083417.69895DE3C5@ozlabs.org>
	<20070126064352.GA328@colo.lackof.org>
	<m1ejpiw9s8.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Sat, 27 Jan 2007 07:50:07 +1100
Message-Id: <1169844607.24996.122.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Grant Grundler <grundler@parisc-linux.org>,
	Greg Kroah-Hartman <greg@kroah.com>,
	Kyle McMartin <kyle@parisc-linux.org>, linuxppc-dev@ozlabs.org,
	Brice Goglin <brice@myri.com>, shaohua.li@intel.com,
	linux-pci@atrey.karlin.mff.cuni.cz, "David S.Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-01-26 at 00:02 -0700, Eric W. Biederman wrote:

> I don't have a clue why it is called virq.  But looking at the
> usage it must be a linux irq number as shown in /proc/interrupts and
> as such there need be no connection with hardware.

Indeed.

> I believe the ppc model is to allocate an interrupt source on their
> existing interrupt controller and use that instead of the normal x86
> case of having the MSI interrupt go transparently to the cpu.

Not quite, see my other reply.

> Both set_irq_type, and entries.vector take a linux irq number.
> Darn we should change that field name, it is misleading.

Yes ;-)

Ben.
