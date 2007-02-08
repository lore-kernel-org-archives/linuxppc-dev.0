Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EB110DDE45
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 19:22:34 +1100 (EST)
Date: Thu, 08 Feb 2007 17:22:07 +0900 (JST)
Message-Id: <200702080822.l188MFxp028975@toshiba.co.jp>
To: paulus@samba.org
Subject: Re: [PATCH 10/11] Celleb: basic support
In-Reply-To: <17866.46314.560561.936484@cargo.ozlabs.ibm.com>
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul-san,

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
> arch/powerpc/Kconfig:569:warning: 'select' used by config symbol
'PPC_CELLEB' refer to undefined symbol 'USB_OHCI_BIG_ENDIAN_MMIO'
> arch/powerpc/Kconfig:570:warning: 'select' used by config symbol
'PPC_CELLEB' refer to undefined symbol 'USB_EHCI_BIG_ENDIAN_MMIO'
> 
> I applied this patch anyway.  Is this something that will get fixed by
> changes you have submitted to the USB maintainer, or is some other fix
> required?

These symbols will be introduced by USB subsystem. The patch was
posted by Ben-san and was already accepted for 2.6.21.

Best regards,
Kou Ishizaki
