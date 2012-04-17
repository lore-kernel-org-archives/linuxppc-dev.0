Return-Path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1334661361-3699-1-git-send-email-valentin.ilie@gmail.com>
References: <1334661361-3699-1-git-send-email-valentin.ilie@gmail.com>
Date: Tue, 17 Apr 2012 14:53:12 +0200
Message-ID: <CAMuHMdUQmTzjVfb=fwKJCmov+OuFYDHU-wW4T2kEXigpVxeGPg@mail.gmail.com>
Subject: Re: [PATCH] Drivers: ps3: ps3av.c: fixed checkpatch warnings
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Valentin Ilie <valentin.ilie@gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: geoff@infradead.org, cbe-oss-dev@lists.ozlabs.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 17, 2012 at 13:16, Valentin Ilie <valentin.ilie@gmail.com> wrot=
e:
> diff --git a/drivers/ps3/ps3av.c b/drivers/ps3/ps3av.c
> index a409fa0..46136b0 100644
> --- a/drivers/ps3/ps3av.c
> +++ b/drivers/ps3/ps3av.c
> @@ -25,8 +25,8 @@
> =C2=A0#include <linux/ioctl.h>
> =C2=A0#include <linux/fb.h>
> =C2=A0#include <linux/slab.h>
> +#include <linux/firmware.h>
>
> -#include <asm/firmware.h>

NAK. It really needs <asm/firmware.h> (have you compiled the result?).

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
