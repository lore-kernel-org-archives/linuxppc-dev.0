Return-Path: <tommusta@gmail.com>
Received: from mail-yh0-x236.google.com (mail-yh0-x236.google.com
 [IPv6:2607:f8b0:4002:c01::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7C7AF2C03AB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Oct 2013 08:46:08 +1100 (EST)
Received: by mail-yh0-f54.google.com with SMTP id b20so873158yha.41
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Oct 2013 14:46:03 -0700 (PDT)
Message-ID: <52717E16.3030706@gmail.com>
Date: Wed, 30 Oct 2013 16:45:58 -0500
From: Tom Musta <tommusta@gmail.com>
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/3] powerpc: Enable emulate_step In Little Endian Mode
References: <1382125125.2206.22.camel@tmusta-sc.rchland.ibm.com>	<1382125235.2206.24.camel@tmusta-sc.rchland.ibm.com>	<878uxairi8.fsf@igel.home>	<52715F7F.8020206@gmail.com>
 <CAMuHMdWMZNF_KOMyVES2UbvCyGEH1N=CFp-TTWuLMzm89SLs3A@mail.gmail.com>
In-Reply-To: <CAMuHMdWMZNF_KOMyVES2UbvCyGEH1N=CFp-TTWuLMzm89SLs3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 10/30/2013 2:43 PM, Geert Uytterhoeven wrote:
> On Wed, Oct 30, 2013 at 8:35 PM, Tom Musta <tommusta@gmail.com> wrote:
>> On 10/30/2013 12:43 PM, Andreas Schwab wrote:
>>>
>>> Tom Musta <tommusta@gmail.com> writes:
>>>
>>>> +#ifdef __LITTLE_ENDIAN__
>>>> +       if (!regs->msr & MSR_LE)
>>>
>>>
>>> That won't work.
>>>
>>> Andreas.
>>>
>>
>> Please elaborate.
>
> You want to test for "!(regs & MSR_LE)".
>
> Gr{oetje,eeting}s,
>
>                          Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
>

Thanks Adnreas and Geert.  I will fix and resubmit.
