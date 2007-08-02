Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A0108DDD08
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Aug 2007 15:12:14 +1000 (EST)
From: kou.ishizaki@toshiba.co.jp
Date: Thu, 02 Aug 2007 14:11:49 +0900 (JST)
Message-Id: <20070802.141149.-1300528740.kouish@swc.toshiba.co.jp>
To: paulus@samba.org
Subject: Re: [PATCH] [POWERPC] Fix section mismatch references to
Cc: sfr@canb.auug.org.au, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

alloc_bootmem
In-Reply-To: <20070731171407.c1028de4.sfr@canb.auug.org.au>
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
X-Mailer: Mew version 4.2 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> WARNING: vmlinux.o(.text+0x2a9c4): Section mismatch: reference to
.init.text:.__alloc_bootmem (between '.update_dn_pci_info' and
'.pci_dn_reconfig_notifier')
> WARNING: vmlinux.o(.text+0x36430): Section mismatch: reference to
.init.text:.__alloc_bootmem (between '.mpic_msi_init_allocator' and
'.find_ht_magic_addr')
> WARNING: vmlinux.o(.text+0x5e804): Section mismatch: reference to
.init.text:.__alloc_bootmem (between '.celleb_setup_phb' and
'.celleb_fake_pci_write_config')
> WARNING: vmlinux.o(.text+0x5e8e8): Section mismatch: reference to
.init.text:.__alloc_bootmem (between '.celleb_setup_phb' and
'.celleb_fake_pci_write_config')
> WARNING: vmlinux.o(.text+0x5e968): Section mismatch: reference to
.init.text:.__alloc_bootmem (between '.celleb_setup_phb' and
'.celleb_fake_pci_write_config')
> WARNING: vmlinux.o(.text+0x5ec50): Section mismatch: reference to
.init.text:.free_bootmem (between '.celleb_setup_phb' and
'.celleb_fake_pci_write_config')
> WARNING: vmlinux.o(.text+0x5ec70): Section mismatch: reference to
.init.text:.free_bootmem (between '.celleb_setup_phb' and
'.celleb_fake_pci_write_config')
> WARNING: vmlinux.o(.text+0x5eb88): Section mismatch: reference to
.init.text:.free_bootmem (between '.celleb_setup_phb' and
'.celleb_fake_pci_write_config')
> WARNING: vmlinux.o(.text+0x5eba8): Section mismatch: reference to
.init.text:.free_bootmem (between '.celleb_setup_phb' and
'.celleb_fake_pci_write_config')
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>


There is no problem in this patch for Celleb platform, and it looks
fine.

I have already posted another patch to remove warnings:
  http://patchwork.ozlabs.org/linuxppc/patch?id=12656
It will not conflict with this patch, and I hope both of them to be
applied.

Best regards,
Kou Ishizaki
