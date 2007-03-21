Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 31F0EDDEF8
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 07:24:26 +1100 (EST)
Subject: Re: [PATCH 4/4] Add irq debugfs and virq_mapping for getting the
	virq to irq host's hwirq mapping list.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <65a42fd7d277db5f565849a07d8dea90@kernel.crashing.org>
References: <11740199151814-git-send-email-wei.zhang@freescale.com>
	<11740199152595-git-send-email-wei.zhang@freescale.com>
	<11740199154116-git-send-email-wei.zhang@freescale.com>
	<11740199152381-git-send-email-wei.zhang@freescale.com>
	<1174359820.10827.8.camel@concordia.ozlabs.ibm.com>
	<65a42fd7d277db5f565849a07d8dea90@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 22 Mar 2007 07:24:11 +1100
Message-Id: <1174508651.10836.4.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, r54964@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-03-21 at 15:17 +0100, Segher Boessenkool wrote:
> >> This patch adds 'irq' directory into the root debugfs and 
> >> virq_mapping for getting the virq to
> >> irq host's hwirq mapping list.
> >
> > Minor nit. Should we be creating a 'powerpc' directory first, and
> > putting the 'irq' file under that? Otherwise we risk clashing with some
> > generic code that creates a file called 'irq' in debugfs.
> 
> Or put the whole IRQ tree under sysfs generically...

Except that there is no such thing as an IRQ tree in the generic code...

Ben.
