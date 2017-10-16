Return-Path: <bsingharora@gmail.com>
Received: from mail-vk0-x22a.google.com (mail-vk0-x22a.google.com
 [IPv6:2607:f8b0:400c:c05::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yFmvR5TLbzDrFt
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Oct 2017 16:23:47 +1100 (AEDT)
Received: by mail-vk0-x22a.google.com with SMTP id q80so6959528vka.7
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Oct 2017 22:23:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87shejlloi.fsf@concordia.ellerman.id.au>
References: <20170929042655.14570-1-bsingharora@gmail.com>
 <20170929042655.14570-2-bsingharora@gmail.com>
 <87shejlloi.fsf@concordia.ellerman.id.au>
From: Balbir Singh <bsingharora@gmail.com>
Date: Mon, 16 Oct 2017 16:23:44 +1100
Message-ID: <CAKTCnznV+NE=M_6Fovnjf9O+G985tVgm57F_xDc2UZksSnWhyA@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] powerpc/mce.c: Remove unused function
 get_mce_fault_addr()
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 16, 2017 at 4:13 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Balbir Singh <bsingharora@gmail.com> writes:
>
>> There are no users of get_mce_fault_addr()
>>
>> Fixes: b63a0ff ("powerpc/powernv: Machine check exception handling.")
>
> That fixes line is wrong, get_mce_fault_addr() was used in that commit.
>
> The last usage was removed in:
>
>   1363875bdb63 ("powerpc/64s: fix handling of non-synchronous machine checks")
>
> So that's what the fixes tag should point at if anything, I'll update it
> here.

Sorry, my git search was really awe-full! Thanks for fixing it.

Balbir Singh
