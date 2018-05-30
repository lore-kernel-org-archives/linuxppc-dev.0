Return-Path: <yamada.masahiro@socionext.com>
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com
 [210.131.2.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40wty03GVDzDr6B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 May 2018 00:58:15 +1000 (AEST)
Received: from mail-vk0-f46.google.com (mail-vk0-f46.google.com
 [209.85.213.46]) (authenticated)
 by conssluserg-04.nifty.com with ESMTP id w4UEvq3V011689
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2018 23:57:53 +0900
Received: by mail-vk0-f46.google.com with SMTP id x191-v6so11281400vke.10
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2018 07:57:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87o9gxyzpo.fsf@concordia.ellerman.id.au>
References: <20180530121922.22122-1-npiggin@gmail.com>
 <87o9gxyzpo.fsf@concordia.ellerman.id.au>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 30 May 2018 23:57:11 +0900
Message-ID: <CAK7LNARoj4g5Wf2Do1npiQUeTpiiFZLuNdmW4JfZw2D-Oe++jw@mail.gmail.com>
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

2018-05-30 23:39 GMT+09:00 Michael Ellerman <mpe@ellerman.id.au>:
> Nicholas Piggin <npiggin@gmail.com> writes:
>
>> This series of patches improves th powerpc kbuild system. The
>> motivation was to to be compatible with the new Kconfig scripting
>> language that Yamada-san has implemented here for merge:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git/log/?h=kconfig
>>
>> I have tested on top of that tree, powerpc now builds there.
>>
>> To avoid build breakage, the first 3 patches must go before the
>> kconfig change, and the 4th patch must go after it.
>>
>> v5 changes:
>> - Patch 4 update to syntax changed since kconfig-shell-v3 release.
>> - Patch 4 suggestions from Masahiro Yamada, remove unnecessary "OK"
>>   output from check mprofile script, and fold CC_USING_MPROFILE_KERNEL
>>   into CONFIG_MPROFILE_KERNEL.
>> - Reduce whitespace disturbance in patch 1.
>
> I've put this series in a topic branch.
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/log/?h=topic/kbuild


No, you can't.

This series depends on my Kconfig work.

You queued it up on v4.17-rc3,
but necessary patches are not there.

You will get build errors.


>
> I'll plan to merge the first three into the powerpc tree.

Please do not do this.

You can issue Acked-by instead.


I need all the 4 patches to my tree.
Otherwise, the git-bisect'ability breaks for PowerPC.

See, the PPC breakage report from Stephen Rothwell
https://lkml.org/lkml/2018/5/29/1296




> Masahiro, are you planning to merge your kconfig changes for 4.18? If so
> you could merge the whole branch and everything should merge nicely.

Yes.

I already queued my and Nicholas' patches.

git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild kconfig


Nicholas,

Please check if the patch order is correct.


I need to insert 'powerpc/kbuild' patches between.



> cheers
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
