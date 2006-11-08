Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 26A4A67DF2
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Nov 2006 11:15:48 +1100 (EST)
Subject: Re: [RFC/PATCH 4/7] Powerpc MSI implementation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <m1mz727syy.fsf@ebiederm.dsl.xmission.com>
References: <1162884080.585336.70559261997.qpush@cradle>
	<20061107072125.68E9F67CA7@ozlabs.org>
	<20061107200730.GY27140@parisc-linux.org>
	<20061107201436.GE9533@flint.arm.linux.org.uk>
	<20061107204432.GZ27140@parisc-linux.org>
	<20061107204853.GF9533@flint.arm.linux.org.uk>
	<20061107210202.GA27140@parisc-linux.org>
	<20061107222514.GG9533@flint.arm.linux.org.uk>
	<1162938562.28571.531.camel@localhost.localdomain>
	<m1mz727syy.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Wed, 08 Nov 2006 11:15:04 +1100
Message-Id: <1162944905.28571.551.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Matthew Wilcox <matthew@wil.cx>, Greg Kroah-Hartman <greg@kroah.com>,
	Ingo Molnar <mingo@elte.hu>,
	Russell King <rmk-pci@arm.linux.org.uk>, linuxppc-dev@ozlabs.org,
	Thomas Gleixner <tglx@linutronix.de>, linux-pci@atrey.karlin.mff.cuni.cz,
	"David S.Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> For message signalled interrupts and hyptertransport interrupts we probably want
> to add an additional field for pointing to their per irq state.  Per device
> interrupt controllers are truly peculiar.

A per-irq addition field for the MSI data might indeed be useful. I
still want to store it in the pci_dev, but it would be good to have a
pointer to it in the irq_desc.

Ben.
 
