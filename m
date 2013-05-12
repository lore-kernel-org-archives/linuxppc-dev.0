Return-Path: <geert@linux-m68k.org>
Received: from winston.telenet-ops.be (winston.telenet-ops.be [195.130.137.75])
 by ozlabs.org (Postfix) with ESMTP id 93F492C00A5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 May 2013 06:47:18 +1000 (EST)
Received: from gerard.telenet-ops.be (gerard.telenet-ops.be [195.130.132.48])
 by winston.telenet-ops.be (Postfix) with ESMTP id 1FB3E1BCB47
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 May 2013 22:47:15 +0200 (CEST)
Date: Sun, 12 May 2013 22:47:14 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@linux-m68k.org
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Build regressions/improvements in v3.10-rc1 (powerpc)
In-Reply-To: <alpine.DEB.2.00.1305122239040.5463@ayla.of.borg>
Message-ID: <alpine.DEB.2.00.1305122246440.5463@ayla.of.borg>
References: <alpine.DEB.2.00.1305122130270.3789@ayla.of.borg>
 <alpine.DEB.2.00.1305122239040.5463@ayla.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux/PPC Development <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 12 May 2013, Geert Uytterhoeven wrote:
> However, the full list of errors isn't that unmanageable, so I'm following
> up with a digested list...

arch/powerpc/kernel/fadump.c:408:2: error: 'crashing_cpu' undeclared (first use in this function): 1 errors in 1 logs
arch/powerpc/kernel/fadump.c:410:2: error: implicit declaration of function 'crash_save_vmcoreinfo' [-Werror=implicit-function-declaration]: 1 errors in 1 logs
arch/powerpc/kernel/fadump.c:513:22: error: storage size of 'prstatus' isn't known: 1 errors in 1 logs
arch/powerpc/kernel/fadump.c:520:2: error: implicit declaration of function 'elf_core_copy_kernel_regs' [-Werror=implicit-function-declaration]: 1 errors in 1 logs
arch/powerpc/kernel/fadump.c:521:36: error: 'KEXEC_CORE_NOTE_NAME' undeclared (first use in this function): 1 errors in 1 logs
arch/powerpc/kernel/fadump.c:624:49: error: 'note_buf_t' undeclared (first use in this function): 1 errors in 1 logs
arch/powerpc/kernel/fadump.c:872:2: error: implicit declaration of function 'paddr_vmcoreinfo_note' [-Werror=implicit-function-declaration]: 1 errors in 1 logs
arch/powerpc/kernel/fadump.c:874:18: error: 'vmcoreinfo_max_size' undeclared (first use in this function): 1 errors in 1 logs
arch/powerpc/platforms/cell/spufs/inode.c:623:16: error: incompatible types when assigning to type 'kuid_t' from type 'int': 1 errors in 1 logs
arch/powerpc/platforms/cell/spufs/inode.c:628:16: error: incompatible types when assigning to type 'kgid_t' from type 'int': 1 errors in 1 logs
	v3.10-rc1/powerpc/powerpc-randconfig

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
