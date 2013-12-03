Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-pb0-x236.google.com (mail-pb0-x236.google.com
 [IPv6:2607:f8b0:400e:c01::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AA94A2C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Dec 2013 08:01:30 +1100 (EST)
Received: by mail-pb0-f54.google.com with SMTP id un15so21784334pbc.41
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Dec 2013 13:01:27 -0800 (PST)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20131203204540.GA4796@roeck-us.net>
References: <1385891092-13266-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdV1hoUnYixPghCAy-LuTaB9JU-BFfBPH06gxhLRAqfp8Q@mail.gmail.com>
 <20131203204540.GA4796@roeck-us.net>
Date: Tue, 3 Dec 2013 22:01:27 +0100
Message-ID: <CAMuHMdXsn9R6-R5yMCnjEmum5LjBRmL8+v+_ryvRLJyQBg1ZtA@mail.gmail.com>
Subject: Re: Build regressions/improvements in v3.13-rc2
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Cc: sparclinux <sparclinux@vger.kernel.org>,
 "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux-sh list <linux-sh@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Dec 3, 2013 at 9:45 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> ia64-defconfig:
>
> arch/ia64/kernel/built-in.o: In function `skip_rbs_switch':
> (.text+0xef2): undefined reference to `preempt_schedule_irq'

Funny, that one was actually introduced in v3.13-rc1, but it fell through
the cracks of the regex handling in my script.

BTW, my scripts are back online: https://github.com/geertu/linux-scripts.
linux-log-diff didn't see the ia64 breakage, linux-log-summary did.
One day I plan to merge linux-log-diff and linux-log-summary, so I have
to maintain only one regex chain.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
