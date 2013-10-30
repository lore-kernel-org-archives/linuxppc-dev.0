Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-pa0-x22d.google.com (mail-pa0-x22d.google.com
 [IPv6:2607:f8b0:400e:c03::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7D0312C0379
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Oct 2013 06:43:51 +1100 (EST)
Received: by mail-pa0-f45.google.com with SMTP id kp14so1433330pab.18
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Oct 2013 12:43:47 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <52715F7F.8020206@gmail.com>
References: <1382125125.2206.22.camel@tmusta-sc.rchland.ibm.com>
 <1382125235.2206.24.camel@tmusta-sc.rchland.ibm.com>
 <878uxairi8.fsf@igel.home> <52715F7F.8020206@gmail.com>
Date: Wed, 30 Oct 2013 20:43:47 +0100
Message-ID: <CAMuHMdWMZNF_KOMyVES2UbvCyGEH1N=CFp-TTWuLMzm89SLs3A@mail.gmail.com>
Subject: Re: [PATCH 1/3] powerpc: Enable emulate_step In Little Endian Mode
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Tom Musta <tommusta@gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, tmusta@gmail.com,
 Andreas Schwab <schwab@linux-m68k.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 30, 2013 at 8:35 PM, Tom Musta <tommusta@gmail.com> wrote:
> On 10/30/2013 12:43 PM, Andreas Schwab wrote:
>>
>> Tom Musta <tommusta@gmail.com> writes:
>>
>>> +#ifdef __LITTLE_ENDIAN__
>>> +       if (!regs->msr & MSR_LE)
>>
>>
>> That won't work.
>>
>> Andreas.
>>
>
> Please elaborate.

You want to test for "!(regs & MSR_LE)".

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
