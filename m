Return-Path: <geert@linux-m68k.org>
Received: from wilson.telenet-ops.be (wilson.telenet-ops.be [195.130.132.42])
 by ozlabs.org (Postfix) with ESMTP id 8E03A2C00A5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 May 2013 04:46:53 +1000 (EST)
Received: from georges.telenet-ops.be (georges.telenet-ops.be [195.130.137.68])
 by wilson.telenet-ops.be (Postfix) with ESMTP id 38EE7341B0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 May 2013 20:36:06 +0200 (CEST)
Date: Wed, 22 May 2013 20:36:04 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@linux-m68k.org
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Build regressions/improvements in v3.10-rc2
In-Reply-To: <alpine.DEB.2.00.1305222034040.25309@ayla.of.borg>
Message-ID: <alpine.DEB.2.00.1305222035230.25364@ayla.of.borg>
References: <alpine.DEB.2.00.1305222034040.25309@ayla.of.borg>
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

On Wed, 22 May 2013, Geert Uytterhoeven wrote:
> JFYI, when comparing v3.10-rc2 to v3.10-rc1[3], the summaries are:
>   - build errors: +2/-13

One false positive due to a line concatenation, and

  + error: drivers/built-in.o: undefined reference to `il_pm_ops':  => .data+0x51ce4)

powerpc-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/6246/ (120 out of 118 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/6218/ (all 118 configs)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
