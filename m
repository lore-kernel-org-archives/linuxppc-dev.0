Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17866.46314.560561.936484@cargo.ozlabs.ibm.com>
Date: Thu, 8 Feb 2007 16:28:10 +1100
From: Paul Mackerras <paulus@samba.org>
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Subject: Re: [PATCH 10/11] Celleb: basic support
In-Reply-To: <200701261219.l0QCJAG1024510@toshiba.co.jp>
References: <200701261219.l0QCJAG1024510@toshiba.co.jp>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ishizaki Kou writes:

> +config PPC_CELLEB
> +	bool "Toshiba's Cell Reference Set 'Celleb' Architecture"
> +	depends on PPC_MULTIPLATFORM && PPC64
> +	select PPC_CELL
> +	select PPC_OF_PLATFORM_PCI
> +	select HAS_TXX9_SERIAL
> +	select PPC_UDBG_BEAT
> +	select USB_OHCI_BIG_ENDIAN_MMIO
> +	select USB_EHCI_BIG_ENDIAN_MMIO

I get:

scripts/kconfig/conf -s arch/powerpc/Kconfig
arch/powerpc/Kconfig:569:warning: 'select' used by config symbol 'PPC_CELLEB' refer to undefined symbol 'USB_OHCI_BIG_ENDIAN_MMIO'
arch/powerpc/Kconfig:570:warning: 'select' used by config symbol 'PPC_CELLEB' refer to undefined symbol 'USB_EHCI_BIG_ENDIAN_MMIO'

I applied this patch anyway.  Is this something that will get fixed by
changes you have submitted to the USB maintainer, or is some other fix
required?

Paul.
