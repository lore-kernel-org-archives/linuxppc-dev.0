Return-Path: <yamada.masahiro@socionext.com>
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com
 [210.131.2.80])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40y1Ps6gB9zDr2n
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jun 2018 20:52:49 +1000 (AEST)
Received: from mail-vk0-f44.google.com (mail-vk0-f44.google.com
 [209.85.213.44]) (authenticated)
 by conssluserg-01.nifty.com with ESMTP id w51AqSZO008149
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Jun 2018 19:52:29 +0900
Received: by mail-vk0-f44.google.com with SMTP id 128-v6so9884791vkf.8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Jun 2018 03:52:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <871sdq4wxp.fsf@concordia.ellerman.id.au>
References: <20180530121922.22122-1-npiggin@gmail.com>
 <87o9gxyzpo.fsf@concordia.ellerman.id.au>
 <CAK7LNARoj4g5Wf2Do1npiQUeTpiiFZLuNdmW4JfZw2D-Oe++jw@mail.gmail.com>
 <87k1rkzbry.fsf@concordia.ellerman.id.au>
 <CAK7LNARbz8YC7=vB_Pt-FFepLfLY-Yt=8ZiOAoPeZV3EA3VQOg@mail.gmail.com>
 <876034yrek.fsf@concordia.ellerman.id.au>
 <CAK7LNASxgQOsSveFuKrx7do-+643KUZwU_Gn+z7O7JK+TtMEww@mail.gmail.com>
 <871sdq4wxp.fsf@concordia.ellerman.id.au>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 1 Jun 2018 19:51:47 +0900
Message-ID: <CAK7LNASwEv8RGi=PtKyDjcwt9DFy93ug22xQAWOJ2b5j+yNkqg@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] powerpc patches for new Kconfig language
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi.

2018-06-01 19:34 GMT+09:00 Michael Ellerman <mpe@ellerman.id.au>:
> Hi Masahiro,
>
> Masahiro Yamada <yamada.masahiro@socionext.com> writes:
> ...
>>
>> Also, the change logs could be dropped.
>>
>> I see
>>
>> Since v1: reworded changelog to explain the cause of the problem (thanks
>> Segher) and moved the flags into the 64-32 cross compile case.
>>
>> or
>>
>> Since v1: removed extra -EB in the recordmcount script (thanks mpe)
>>
>>
>> above your signed-off-by.
>>
>>
>> Of course, this is your call,
>> and you do not need to disturb the git history if it is too late.
>
> You're right, sorry those are bit messy.
>
> I'm happy to update them, I haven't merged them yet, but I see you have
> them in your tree.
>
> So I won't change them unless you confirm you're OK with it. Let me
> know.


Could you update your branch, please?

Then, I will re-pull the new one.

Thanks!



-- 
Best Regards
Masahiro Yamada
