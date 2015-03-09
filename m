Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-ob0-x22d.google.com (mail-ob0-x22d.google.com
 [IPv6:2607:f8b0:4003:c01::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7ADE61A20D1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 01:27:26 +1100 (AEDT)
Received: by obbnt9 with SMTP id nt9so9228238obb.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Mar 2015 07:27:22 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <4677994.NrntHOKO7A@wuerfel>
References: <1425898222-19721-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdVNWVKA0iuTMABQPzJJtjCAD_Ey7w1gx2ojYzG4TscyKA@mail.gmail.com>
 <4677994.NrntHOKO7A@wuerfel>
Date: Mon, 9 Mar 2015 15:27:22 +0100
Message-ID: <CAMuHMdXK6dVfMhMTepr2cfVfDVaLpoA9vPn-c=FNkM0dmxin9A@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.0-rc3
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Arnd,

On Mon, Mar 9, 2015 at 3:10 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> smc91x fallout. The lpd270_defconfig failure looks like not covered by
>> "ARM: fix typos in smc91x platform data" yet?
>
> It's not?
>
> This should be part of that patch:
>
> --- a/arch/arm/mach-pxa/lpd270.c
> +++ b/arch/arm/mach-pxa/lpd270.c
> @@ -195,7 +195,7 @@ static struct resource smc91x_resources[] = {
>  };
>
>  struct smc91x_platdata smc91x_platdata = {
> -       .flags = SMC91X_USE_16BIT | SMC91X_NOWAIT;
> +       .flags = SMC91X_USE_16BIT | SMC91X_NOWAIT,

Ah OK. Sorry, I thought there was a different reason.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
