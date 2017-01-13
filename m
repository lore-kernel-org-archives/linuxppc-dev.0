Return-Path: <dhowells@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v0RZH4ps3zDqVC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Jan 2017 02:36:54 +1100 (AEDT)
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1484304406-10820-2-git-send-email-nicolas.dichtel@6wind.com>
References: <1484304406-10820-2-git-send-email-nicolas.dichtel@6wind.com>
 <3131144.4Ej3KFWRbz@wuerfel>
 <1484304406-10820-1-git-send-email-nicolas.dichtel@6wind.com>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: dhowells@redhat.com, arnd@arndb.de, linux-mips@linux-mips.org,
 linux-m68k@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-doc@vger.kernel.org, alsa-devel@alsa-project.org,
 dri-devel@lists.freedesktop.org, linux-mtd@lists.infradead.org,
 sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-am33-list@redhat.com,
 linux-c6x-dev@linux-c6x.org, linux-rdma@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-sh@vger.kernel.org,
 linux@armlinux.org.uk, coreteam@netfilter.org,
 fcoe-devel@open-fcoe.org, xen-devel@lists.xenproject.org,
 linux-snps-arc@lists.infradead.org, linux-media@vger.kernel.org,
 uclinux-h8-devel@lists.sourceforge.jp, linux-xtensa@linux-xtensa.org,
 linux-kbuild@vger.kernel.org,
 adi-buildroot-devel@lists.sourceforge.net, linux-raid@vger.kernel.org,
 openrisc@lists.librecores.org, linux-fbdev@vger.kernel.org,
 linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-nfs@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-cris-kernel@axis.com, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
 netfilter-devel@vger.kernel.org, linux-alpha@vger.kernel.org,
 nio2-dev@lists.rocketboards.org, linuxppc-dev@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 13 Jan 2017 15:36:43 +0000
Message-ID: <25063.1484321803@warthog.procyon.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicolas Dichtel <nicolas.dichtel@6wind.com> wrote:

> This header file is exported, thus move it to uapi.

Exported how?

> +#ifdef __INT32_TYPE__
> +#undef __INT32_TYPE__
> +#define __INT32_TYPE__		int
> +#endif
> +
> +#ifdef __UINT32_TYPE__
> +#undef __UINT32_TYPE__
> +#define __UINT32_TYPE__	unsigned int
> +#endif
> +
> +#ifdef __UINTPTR_TYPE__
> +#undef __UINTPTR_TYPE__
> +#define __UINTPTR_TYPE__	unsigned long
> +#endif

These weren't defined by the kernel before, so why do we need to define them
now?

Will defining __UINTPTR_TYPE__ cause problems in compiling libboost by
changing the signature on C++ functions that use uintptr_t?

David
