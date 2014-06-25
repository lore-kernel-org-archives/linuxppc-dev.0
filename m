Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-la0-x234.google.com (mail-la0-x234.google.com
 [IPv6:2a00:1450:4010:c03::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6CE251A0012
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 17:53:50 +1000 (EST)
Received: by mail-la0-f52.google.com with SMTP id ty20so454998lab.39
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 00:53:44 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <53A91449.6010701@roeck-us.net>
References: <1402677499-28289-1-git-send-email-linux@roeck-us.net>
 <1403584501.4587.153.camel@pasglop> <53A90718.4050401@roeck-us.net>
 <1403588053.4587.160.camel@pasglop> <53A91449.6010701@roeck-us.net>
Date: Wed, 25 Jun 2014 09:53:43 +0200
Message-ID: <CAMuHMdUW0aZ__ykR6CC793EM1RSEbYqbWaXtEqKjG4janF-rRQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Fix build warning
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 Paul Mackerras <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 24, 2014 at 8:01 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> Sigh. Much easier to break something than to fix it. That would mean to get
> approval
> from at least three maintainers, and all that to get rid of a warning. I
> don't
> really have time for that. Let's just forget about it and live with the
> warning.

So you send it to akpm. Or perhaps even trivial.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
