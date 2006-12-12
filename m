Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id BB41E67BE8
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 07:00:27 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 13/15] powerpc: add a field for each specific bus to
	sturct pci_controller
Date: Tue, 12 Dec 2006 21:00:10 +0100
References: <200612120406.kBC46klg011193@toshiba.co.jp>
In-Reply-To: <200612120406.kBC46klg011193@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200612122100.11178.arnd@arndb.de>
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 12 December 2006 05:06, Ishizaki Kou wrote:
> struct pci_controller doesn't prepare for the dependent data of each
> specific bus. This patch adds private member to struct pci_controller.
>=20
> Signed-off-by: Kou Ishizaki <kou.ishizaki.co.jp>

Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

=2E.. provided that we actually want "[PATCH 8/15] Supporting PCI bus=20
and base of I/O", without which it is pointless.

Note that you should reorder the patches so that this one comes
before the other, and it would be good to mention the dependency
explicitly.

> ---
>=20
> Index: linux-powerpc-git/include/asm-powerpc/pci-bridge.h
> diff -u linux-powerpc-git/include/asm-powerpc/pci-bridge.h:1.1.1.1 linux-=
powerpc-git/include/asm-powerpc/pci-bridge.h:1.2
> --- linux-powerpc-git/include/asm-powerpc/pci-bridge.h:1.1.1.1=A0=A0Wed D=
ec =A06 08:24:04 2006
> +++ linux-powerpc-git/include/asm-powerpc/pci-bridge.h=A0=A0Fri Dec =A08 =
14:01:27 2006
> @@ -53,6 +53,8 @@
> =A0=A0=A0=A0=A0=A0=A0=A0unsigned long buid;
> =A0=A0=A0=A0=A0=A0=A0=A0unsigned long dma_window_base_cur;
> =A0=A0=A0=A0=A0=A0=A0=A0unsigned long dma_window_size;
> +
> +=A0=A0=A0=A0=A0=A0=A0void *private_data;
> =A0};
