Message-Id: <20010907234420.Postino-012737@smtp01.highway.ne.jp>
Date: Fri, 7 Sep 2001 23:44:20 +0900
To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Cc: linuxppc-dev@lists.linuxppc.org
From: Kaoru Fukui <k_fukui@highway.ne.jp>
Subject: Re: [PATCH] gcc3 compatibility and debugger support
In-Reply-To: <200109061932.OAA12306@lists.linuxppc.org>
References: <200109061932.OAA12306@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Great Franz!

I could rebuild working kernel(2.4 devel) with gcc-3.0.2 pre

Thanks
Kaoru

From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
To: linuxppc-commit@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] gcc3 compatibility and debugger support
Date: Thu, 6 Sep 2001 21:32:59 +0200

> Hi,
>
> this patch fixes up the RELOC macro (which relies on implentation defined
> things in C), so it's possible again to boot a gcc3 compiled kernel. The
> patch guards the problematic code with a NOP inline asm, preventing the
> problematic (but legal) gcc3 optimization.
> The second part makes sure that the current task ends up in a known memory
> location even for UP. This helps JTAG/BDM debuggers a lot (it's very
> expensive to stop CPU/peek CPU reg/restart CPU).
>
> The patch is against 2_4. In 2_4_devel the gcc3 workaround in prom.c can
be
> removed too.
>
> Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
