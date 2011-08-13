Return-Path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1313139173-25049-1-git-send-email-venkatram867@gmail.com>
References: <1313139173-25049-1-git-send-email-venkatram867@gmail.com>
Date: Sat, 13 Aug 2011 16:31:43 +0200
Message-ID: <CAMuHMdVdA8x1NKijH4xsvbr69wOjjMn51Xn3iktbVt0N3Wthig@mail.gmail.com>
Subject: Re: [PATCH] PS3: Fixed Coding Style Issues in ps3av.c
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Venkatram Tummala <venkatram867@gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: geoff@infradead.org, cbe-oss-dev@lists.ozlabs.org,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 12, 2011 at 10:52, Venkatram Tummala <venkatram867@gmail.com> w=
rote:
> diff --git a/drivers/ps3/ps3av.c b/drivers/ps3/ps3av.c
> index a409fa0..e6d1a3d 100644
> --- a/drivers/ps3/ps3av.c
> +++ b/drivers/ps3/ps3av.c
> @@ -26,7 +26,7 @@
> =C2=A0#include <linux/fb.h>
> =C2=A0#include <linux/slab.h>
>
> -#include <asm/firmware.h>
> +#include <linux/firmware.h>

IIRC, arch/powerpc/include/asm/firmware.h is unrelated to linux/firmware.h.
Does it actually compile when not including asm/firmware.h explicitly?

The rest looks OK to me.

Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds
