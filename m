Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-la0-x230.google.com (mail-la0-x230.google.com
 [IPv6:2a00:1450:4010:c03::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D552D1A0A4E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Oct 2014 00:57:15 +1000 (EST)
Received: by mail-la0-f48.google.com with SMTP id gi9so525736lab.35
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Oct 2014 07:57:10 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <542C13FB.80608@suse.de>
References: <1412170086-57971-1-git-send-email-agraf@suse.de>
 <CAMuHMdWEN+q+s6ENoqqD8d0hy=hcZSiWzW3poJFBs8uEBGVuGg@mail.gmail.com>
 <542C13FB.80608@suse.de>
Date: Wed, 1 Oct 2014 16:57:10 +0200
Message-ID: <CAMuHMdVGK2J1QJPWBygNv5yL=thEyPd8TKdfUFsGjiAFHQGXOg@mail.gmail.com>
Subject: Re: [PATCH 00/20] powerpc: Convert power off logic to pm_power_off
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Alexander Graf <agraf@suse.de>
Content-Type: text/plain; charset=UTF-8
Cc: Arnd Bergmann <arnd@arndb.de>, Geoff Levand <geoff@infradead.org>,
 Alistair Popple <alistair@popple.id.au>, Scott Wood <scottwood@freescale.com>,
 Anatolij Gustschin <agust@denx.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Guenter Roeck <linux@roeck-us.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 1, 2014 at 4:47 PM, Alexander Graf <agraf@suse.de> wrote:
>> This is touching the same area as last night's
>> "[RFC PATCH 00/16] kernel: Add support for poweroff handler call chain"
>> https://lkml.org/lkml/2014/9/30/575
>
> I agree, and I think your patch set is walking into a reasonable
> direction. However, I really think it should convert all users of
> pm_power_off - at which point you'll probably get to the same conclusion
> that ppc_md.power_off is a bad idea :).
>
> So in a way, this patch set is semantically a prerequisite to the full
> conversion you'd probably like to do :).
>
> Also, in your cover letter you describe that some methods power off the
> CPU power while others power off the system power. How do you
> distinguish between them with a call chain? You probably won't get
> around to trigger the system power off callback after the CPU power off
> callback ran ;).

I'll let G=C3=BCnther answer that...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
