Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 49D08DDDDB
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Feb 2007 08:18:19 +1100 (EST)
Subject: Re: [PATCH 10/11] Celleb: basic support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17866.46314.560561.936484@cargo.ozlabs.ibm.com>
References: <200701261219.l0QCJAG1024510@toshiba.co.jp>
	<17866.46314.560561.936484@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Fri, 09 Feb 2007 08:18:04 +1100
Message-Id: <1170969484.2620.338.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-02-08 at 16:28 +1100, Paul Mackerras wrote:
> Ishizaki Kou writes:
> 
> > +config PPC_CELLEB
> > +	bool "Toshiba's Cell Reference Set 'Celleb' Architecture"
> > +	depends on PPC_MULTIPLATFORM && PPC64
> > +	select PPC_CELL
> > +	select PPC_OF_PLATFORM_PCI
> > +	select HAS_TXX9_SERIAL
> > +	select PPC_UDBG_BEAT
> > +	select USB_OHCI_BIG_ENDIAN_MMIO
> > +	select USB_EHCI_BIG_ENDIAN_MMIO
> 
> I get:
> 
> scripts/kconfig/conf -s arch/powerpc/Kconfig
> arch/powerpc/Kconfig:569:warning: 'select' used by config symbol 'PPC_CELLEB' refer to undefined symbol 'USB_OHCI_BIG_ENDIAN_MMIO'
> arch/powerpc/Kconfig:570:warning: 'select' used by config symbol 'PPC_CELLEB' refer to undefined symbol 'USB_EHCI_BIG_ENDIAN_MMIO'
> 
> I applied this patch anyway.  Is this something that will get fixed by
> changes you have submitted to the USB maintainer, or is some other fix
> required?

Yes, this will be fixed when some patches in greg's queue have reached
Linus... (looking at git-commit...) and in fact, as of this morning,
they are in Linus tree.

Ben.
