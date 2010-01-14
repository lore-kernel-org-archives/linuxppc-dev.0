Return-Path: <geert.uytterhoeven@gmail.com>
Received: from ey-out-2122.google.com (ey-out-2122.google.com [74.125.78.26])
	by ozlabs.org (Postfix) with ESMTP id 027D61007D6
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Jan 2010 00:38:41 +1100 (EST)
Received: by ey-out-2122.google.com with SMTP id 22so135488eye.33
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jan 2010 05:38:39 -0800 (PST)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <alpine.OSX.2.00.1001110325430.620@localhost>
References: <alpine.OSX.2.00.0911171657290.371@silk.local>
	<10f740e81001071312p451de3c0r93d8d9d2782abde8@mail.gmail.com>
	<alpine.LNX.2.00.1001102340340.22574@nippy.intranet>
	<alpine.OSX.2.00.1001110325430.620@localhost>
Date: Thu, 14 Jan 2010 14:38:39 +0100
Message-ID: <10f740e81001140538n67710bfr17d131a8f4b25137@mail.gmail.com>
Subject: Re: [PATCH 1/2] pmac-zilog: add platform driver, version 3
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Finn Thain <fthain@telegraphics.com.au>
Content-Type: text/plain; charset=UTF-8
Cc: linux-m68k@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jan 10, 2010 at 17:29, Finn Thain <fthain@telegraphics.com.au> wrote:
> Add platform driver support to the pmac-zilog driver, for m68k macs.
> Place the powermac-specific code inside #ifdef CONFIG_PPC_PMAC.
>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
>
> ---
>
> This patch should be applied after "[PATCH 3/13] pmac-zilog: cleanup".
> It obsoletes "[PATCH 4/13] pmac-zilog, mac68k: replace mac68k SCC code
> with platform device" listed in the linux-ppc patchwork.
>
> Version 2 of this patch adopts Geert's suggestions: make better use of
> dev_{dbg,err,info} macros, change platform_driver_register() to
> platform_driver_probe(), and use __init and __exit attributes.
> Version 3 does not #include <macints.h>.

Thanks, applied.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
