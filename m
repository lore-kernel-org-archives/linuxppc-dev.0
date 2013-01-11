Return-Path: <geert@linux-m68k.org>
Received: from winston.telenet-ops.be (winston.telenet-ops.be [195.130.137.75])
 by ozlabs.org (Postfix) with ESMTP id B6DBF2C0319
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Jan 2013 03:19:21 +1100 (EST)
Received: from georges.telenet-ops.be (georges.telenet-ops.be [195.130.137.68])
 by winston.telenet-ops.be (Postfix) with ESMTP id 902571BE568
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2013 17:07:04 +0100 (CET)
Date: Fri, 11 Jan 2013 17:07:03 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@linux-m68k.org
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Build regressions/improvements in v3.8-rc3
In-Reply-To: <alpine.DEB.2.00.1301111704550.22961@ayla.of.borg>
Message-ID: <alpine.DEB.2.00.1301111705170.23005@ayla.of.borg>
References: <alpine.DEB.2.00.1301111704550.22961@ayla.of.borg>
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

On Fri, 11 Jan 2013, Geert Uytterhoeven wrote:
> JFYI, when comparing v3.8-rc3 to v3.8-rc2[3], the summaries are:
>   - build errors: +2/-414

  + arch/powerpc/sysdev/mpic.c: error: case label does not reduce to an integer constant:  => 890:9, 898:9, 886:9, 894:9
  + error: No rule to make target drivers/scsi/aic7xxx/aicasm/*.[chyl]:  => N/A 

powerpc-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/5780/ (all 117 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/5767/ (all 117 configs)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
