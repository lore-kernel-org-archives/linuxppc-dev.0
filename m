Return-Path: <geert@linux-m68k.org>
Received: from wilson.telenet-ops.be (wilson.telenet-ops.be [195.130.132.42])
 by lists.ozlabs.org (Postfix) with ESMTP id CA7A81A0039
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jun 2014 05:47:34 +1000 (EST)
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [195.130.132.52])
 by wilson.telenet-ops.be (Postfix) with ESMTP id BC8AB357BF
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jun 2014 21:35:38 +0200 (CEST)
Date: Mon, 9 Jun 2014 21:35:37 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@linux-m68k.org
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Build regressions/improvements in v3.15-rc8
In-Reply-To: <alpine.DEB.2.02.1406092134180.21165@ayla.of.borg>
Message-ID: <alpine.DEB.2.02.1406092134500.21181@ayla.of.borg>
References: <alpine.DEB.2.02.1406092134180.21165@ayla.of.borg>
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

On Mon, 9 Jun 2014, Geert Uytterhoeven wrote:
> JFYI, when comparing v3.15-rc8[1]  to v3.15-rc7[3], the summaries are:
>   - build errors: +4/-4

  + /scratch/kisskb/src/kernel/bounds.c: error: -mcall-aixdesc must be big endian:  => 1:0
  + /scratch/kisskb/src/scripts/mod/devicetable-offsets.c: error: -mcall-aixdesc must be big endian:  => 1:0
  + /scratch/kisskb/src/scripts/mod/empty.c: error: -mcall-aixdesc must be big endian:  => 1:0
  + <stdin>: error: -mcall-aixdesc must be big endian:  => 1:0

powerpc-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/7532/ (all 119 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/7506/ (all 119 configs)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
