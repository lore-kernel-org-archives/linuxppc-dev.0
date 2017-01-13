Return-Path: <root@6wind.com>
Received: from proxy.6wind.com (host.76.145.23.62.rev.coltfrance.com
 [62.23.145.76])
 by lists.ozlabs.org (Postfix) with ESMTP id 3v0K7w53vRzDqXB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jan 2017 21:47:08 +1100 (AEDT)
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: arnd@arndb.de
Cc: mmarek@suse.com, linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 adi-buildroot-devel@lists.sourceforge.net, linux-c6x-dev@linux-c6x.org,
 linux-cris-kernel@axis.com, uclinux-h8-devel@lists.sourceforge.jp,
 linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org,
 linux-mips@linux-mips.org, linux-am33-list@redhat.com,
 nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
 linux-arch@vger.kernel.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org, linux-media@vger.kernel.org,
 linux-mmc@vger.kernel.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, linux-nfs@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-rdma@vger.kernel.org,
 fcoe-devel@open-fcoe.org, alsa-devel@alsa-project.org,
 linux-fbdev@vger.kernel.org, xen-devel@lists.xenproject.org,
 airlied@linux.ie, davem@davemloft.net, linux@armlinux.org.uk, bp@alien8.de,
 slash.tmp@free.fr, daniel.vetter@ffwll.ch, rmk+kernel@armlinux.org.uk,
 msalter@redhat.com, jengelh@inai.de, hch@infradead.org,
 Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: [PATCH v3 4/8] x86: stop exporting msr-index.h to userland
Date: Fri, 13 Jan 2017 11:46:42 +0100
Message-Id: <1484304406-10820-5-git-send-email-nicolas.dichtel@6wind.com>
In-Reply-To: <1484304406-10820-1-git-send-email-nicolas.dichtel@6wind.com>
References: <3131144.4Ej3KFWRbz@wuerfel>
 <1484304406-10820-1-git-send-email-nicolas.dichtel@6wind.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
 arch/x86/include/uapi/asm/Kbuild | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/include/uapi/asm/Kbuild b/arch/x86/include/uapi/asm/Kbuild
index 3dec769cadf7..1c532b3f18ea 100644
--- a/arch/x86/include/uapi/asm/Kbuild
+++ b/arch/x86/include/uapi/asm/Kbuild
@@ -27,7 +27,6 @@ header-y += ldt.h
 header-y += mce.h
 header-y += mman.h
 header-y += msgbuf.h
-header-y += msr-index.h
 header-y += msr.h
 header-y += mtrr.h
 header-y += param.h
-- 
2.8.1
