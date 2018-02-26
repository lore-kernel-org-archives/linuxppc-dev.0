Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-qk0-x243.google.com (mail-qk0-x243.google.com
 [IPv6:2607:f8b0:400d:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zqcR90W2szF1Nq
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 20:46:28 +1100 (AEDT)
Received: by mail-qk0-x243.google.com with SMTP id v124so18273949qkh.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 01:46:28 -0800 (PST)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20180127235140.EA71C296D4@kvm5.telegraphics.com.au>
References: <20180127235140.EA71C296D4@kvm5.telegraphics.com.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 26 Feb 2018 10:46:25 +0100
Message-ID: <CAMuHMdUuYF7uoH5ZAHsnEv+Y9VJXEUBAiYKxBpHkXpdDMi+FWw@mail.gmail.com>
Subject: Re: [PATCH] macintosh/via-pmu68k: Initialize PMU driver with
 setup_arch and arch_initcall
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jan 28, 2018 at 12:51 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
> The PMU watchdog will power down the system if the kernel is slow
> to start up, e.g. due to unpacking a large initrd. The powerpc
> version of this driver (via-pmu.c) has a solution for the same
> problem. It uses this call sequence:
>
> setup_arch
>         find_via_pmu
>                 init_pmu
> ...
> arch_initcall
>         via_pmu_start
>
> Bring via-pmu68k.c into line with via-pmu.c to fix this issue.
>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Thanks, applied and queue for v4.17.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
