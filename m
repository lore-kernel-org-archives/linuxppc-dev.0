Return-Path: <geert@linux-m68k.org>
Received: from winston.telenet-ops.be (winston.telenet-ops.be [195.130.137.75])
 by lists.ozlabs.org (Postfix) with ESMTP id A98021A0591
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 May 2014 18:38:35 +1000 (EST)
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [195.130.132.52])
 by winston.telenet-ops.be (Postfix) with ESMTP id 9DF011BDEE0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 May 2014 10:38:32 +0200 (CEST)
Date: Tue, 27 May 2014 10:38:31 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@linux-m68k.org
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Build regressions/improvements in v3.15-rc7
In-Reply-To: <alpine.DEB.2.02.1405271035140.13584@ayla.of.borg>
Message-ID: <alpine.DEB.2.02.1405271035420.13614@ayla.of.borg>
References: <alpine.DEB.2.02.1405271035140.13584@ayla.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux/PPC Development <linuxppc-dev@lists.ozlabs.org>,
 linux-sh@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 27 May 2014, Geert Uytterhoeven wrote:
> JFYI, when comparing v3.15-rc7[1]  to v3.15-rc6[3], the summaries are:
>   - build errors: +4/-1

  + /scratch/kisskb/src/drivers/tty/serial/nwpserial.c: error: implicit declaration of function 'udelay' [-Werror=implicit-function-declaration]:  => 53:3

powerpc-randconfig

  + error: No rule to make target drivers/scsi/aic7xxx/aicasm/*.[chyl]:  => N/A

i386-randconfig

  + error: ion.c: undefined reference to `vm_insert_pfn':  => .text+0x66f4c4)
  + error: ion.c: undefined reference to `zap_page_range':  => .text+0x672794)

sh-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/7506/ (all 119 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/7497/ (all 119 configs)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
