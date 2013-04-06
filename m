Return-Path: <geert@linux-m68k.org>
Received: from wilson.telenet-ops.be (wilson.telenet-ops.be [195.130.132.42])
 by ozlabs.org (Postfix) with ESMTP id 86C2D2C00F8
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Apr 2013 22:37:04 +1100 (EST)
Received: from juliette.telenet-ops.be (juliette.telenet-ops.be
 [195.130.137.74])
 by wilson.telenet-ops.be (Postfix) with ESMTP id 9EB7034A6D
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Apr 2013 13:26:42 +0200 (CEST)
Date: Sat, 6 Apr 2013 13:26:41 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@linux-m68k.org
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Build regressions/improvements in v3.9-rc5
In-Reply-To: <alpine.DEB.2.00.1304061323250.9581@ayla.of.borg>
Message-ID: <alpine.DEB.2.00.1304061324130.9593@ayla.of.borg>
References: <alpine.DEB.2.00.1304061323250.9581@ayla.of.borg>
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

On Sat, 6 Apr 2013, Geert Uytterhoeven wrote:
> JFYI, when comparing v3.9-rc5 to v3.9-rc4[3], the summaries are:
>   - build errors: +129/-0

> Note that there may be false regressions, as some logs are incomplete.
> Still, they're build errors/warnings.

I think the only real one (in powerpc-randconfig) is:

+ arch/powerpc/kernel/tm.S: Error: unsupported relocation against THREAD_VR0:  => 323
+ arch/powerpc/kernel/tm.S: Error: unsupported relocation against THREAD_VSCR:  => 320

> [1] http://kisskb.ellerman.id.au/kisskb/head/6041/ (118 out of 117 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/6015/ (80 out of 117 configs)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
