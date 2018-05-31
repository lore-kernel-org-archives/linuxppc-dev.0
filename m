Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40xQm432f5zDr30
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 May 2018 21:51:32 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v5 0/4] powerpc patches for new Kconfig language
In-Reply-To: <CAK7LNARbz8YC7=vB_Pt-FFepLfLY-Yt=8ZiOAoPeZV3EA3VQOg@mail.gmail.com>
References: <20180530121922.22122-1-npiggin@gmail.com>
 <87o9gxyzpo.fsf@concordia.ellerman.id.au>
 <CAK7LNARoj4g5Wf2Do1npiQUeTpiiFZLuNdmW4JfZw2D-Oe++jw@mail.gmail.com>
 <87k1rkzbry.fsf@concordia.ellerman.id.au>
 <CAK7LNARbz8YC7=vB_Pt-FFepLfLY-Yt=8ZiOAoPeZV3EA3VQOg@mail.gmail.com>
Date: Thu, 31 May 2018 21:51:31 +1000
Message-ID: <876034yrek.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Masahiro Yamada <yamada.masahiro@socionext.com> writes:
> 2018-05-31 13:31 GMT+09:00 Michael Ellerman <mpe@ellerman.id.au>:
>> Masahiro Yamada <yamada.masahiro@socionext.com> writes:
>>> 2018-05-30 23:39 GMT+09:00 Michael Ellerman <mpe@ellerman.id.au>:
>>>> Nicholas Piggin <npiggin@gmail.com> writes:
>>>>
>>>>> This series of patches improves th powerpc kbuild system. The
>>>>> motivation was to to be compatible with the new Kconfig scripting
>>>>> language that Yamada-san has implemented here for merge:
>>>>>
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git/log/?h=kconfig
>>>>>
>>>>> I have tested on top of that tree, powerpc now builds there.
>>>>>
>>>>> To avoid build breakage, the first 3 patches must go before the
>>>>> kconfig change, and the 4th patch must go after it.
>>>>>
>>>>> v5 changes:
>>>>> - Patch 4 update to syntax changed since kconfig-shell-v3 release.
>>>>> - Patch 4 suggestions from Masahiro Yamada, remove unnecessary "OK"
>>>>>   output from check mprofile script, and fold CC_USING_MPROFILE_KERNEL
>>>>>   into CONFIG_MPROFILE_KERNEL.
>>>>> - Reduce whitespace disturbance in patch 1.
>>>>
>>>> I've put this series in a topic branch.
>>>>
>>>>   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/log/?h=topic/kbuild
>>>
>>>
>>> No, you can't.
>>>
>>> This series depends on my Kconfig work.
>>
>> The *last* commit depends on your work, the rest do not.
>>
>>> You queued it up on v4.17-rc3,
>>> but necessary patches are not there.
>>>
>>> You will get build errors.
>>
>> I do not get any build errors for the first three commits.
>
>
> Right, the first three are fine.
>
> If we make sure commit cfff26c2dc7a1
> does not appear in Linus' tree,
> we are good.

Yep agreed.

>>>> I'll plan to merge the first three into the powerpc tree.
>>>
>>> Please do not do this.
>>>
>>> You can issue Acked-by instead.
>>
>> I'd prefer the first three commits were in my tree so they're tested
>> properly.
>>
>>> I need all the 4 patches to my tree.
>>> Otherwise, the git-bisect'ability breaks for PowerPC.
>>
>> You should merge all 4 into your tree, ie. all of my topic/kbuild
>> branch.
>
> This depends on what "merge" means.
>
> If it means "git pull", I cannot pull your topic/kbuild branch
> since it is broken.

Yeah OK I understand what you mean now.

> So, how do you want me to handle the last patch?
>
> I can pull the first three from your branch,
> then I can cherry-pick the last one on top of my kconfig tree.

Yes, please do that.

cheers
