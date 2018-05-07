Return-Path: <yamada.masahiro@socionext.com>
Received: from condef-03.nifty.com (condef-03.nifty.com [202.248.20.68])
 by lists.ozlabs.org (Postfix) with ESMTP id 40fPVX0B3tzDrK4
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 May 2018 11:02:43 +1000 (AEST)
Received: from conssluserg-03.nifty.com ([10.126.8.82])by condef-03.nifty.com
 with ESMTP id w470m0vG012115
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 May 2018 09:48:00 +0900
Received: from mail-vk0-f50.google.com (mail-vk0-f50.google.com
 [209.85.213.50]) (authenticated)
 by conssluserg-03.nifty.com with ESMTP id w470lOVM020352
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 May 2018 09:47:25 +0900
Received: by mail-vk0-f50.google.com with SMTP id x66-v6so11898243vka.11
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 06 May 2018 17:47:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180420204104.6e22b136@roar.ozlabs.ibm.com>
References: <20180420073414.23169-1-npiggin@gmail.com>
 <20180420073414.23169-5-npiggin@gmail.com>
 <CA+7wUswuyn+YgNe732rQAzVmgDBohTMEqwsd76nQ_CH5h7Y5WA@mail.gmail.com>
 <20180420204104.6e22b136@roar.ozlabs.ibm.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 7 May 2018 09:46:43 +0900
Message-ID: <CAK7LNASvOwam=AhN11sUKvBbtJbBzQULqs8kRV2KRS45jbSLcQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] powerpc: Allow LD_DEAD_CODE_DATA_ELIMINATION to be
 selected
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Mathieu Malaterre <malat@debian.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-arch <linux-arch@vger.kernel.org>, Nicolas Pitre <nico@fluxnic.net>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Nicholas,

2018-04-20 19:41 GMT+09:00 Nicholas Piggin <npiggin@gmail.com>:
> On Fri, 20 Apr 2018 12:00:49 +0200
> Mathieu Malaterre <malat@debian.org> wrote:
>
>> On Fri, Apr 20, 2018 at 9:34 AM, Nicholas Piggin <npiggin@gmail.com> wrote:
>> > This requires further changes to linker script to KEEP some tables
>> > and wildcard compiler generated sections into the right place. This
>> > includes pp32 modifications from Christophe Leroy.
>> >
>> > When compiling powernv_defconfig with this option:
>> >
>> > text       data      bss       dec        filename
>> > 11827621   4810490   1341080   17979191   vmlinux
>> > 11752437   4598858   1338776   17690071   vmlinux.dcde
>> >
>> > Resulting kernel is almost 400kB smaller (and still boots).
>> >
>> > [ppc32 numbers here]
>>
>> ^^^
>>
>> Do you want somebody else to provide those numbers ?
>
> If you have a booting kernel, yes some more numbers would be good.
>
> Thanks,
> Nick



I applied this series because I want it to be more tested in linux-next.


Some requests:

 - Could you provide information to replace '[ppc32 numbers here]'?
   (or just remove it)

 - V2 is welcome if you have code improvement.
   (I thought so from your comments)

Thanks.


-- 
Best Regards
Masahiro Yamada
