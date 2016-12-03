Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tWRcD6nglzDvxC
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Dec 2016 10:11:56 +1100 (AEDT)
Received: from mail-ua0-x244.google.com (mail-ua0-x244.google.com
 [IPv6:2607:f8b0:400c:c08::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tWRcD0mfzz9t1L
 for <linuxppc-dev@ozlabs.org>; Sun,  4 Dec 2016 10:11:56 +1100 (AEDT)
Received: by mail-ua0-x244.google.com with SMTP id 50so28482411uae.2
 for <linuxppc-dev@ozlabs.org>; Sat, 03 Dec 2016 15:11:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <3tW80D3NKxz9t1B@ozlabs.org>
References: <1479471342-24195-1-git-send-email-mpe@ellerman.id.au>
 <3tW80D3NKxz9t1B@ozlabs.org>
From: Balbir Singh <bsingharora@gmail.com>
Date: Sun, 4 Dec 2016 10:11:53 +1100
Message-ID: <CAKTCnzngiHahPRY+2KG5hT5JK3uCbWM83rvxcAaJEiC_hSDjiA@mail.gmail.com>
Subject: Re: [1/2] powerpc/prom: Define structs for client architecture vectors
To: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Dec 3, 2016 at 10:28 PM, Michael Ellerman
<patch-notifications@ellerman.id.au> wrote:
> On Fri, 2016-11-18 at 12:15:41 UTC, Michael Ellerman wrote:
>> The "client architecture vectors" are a series of structures we pass to
>> firmware to define various things, such as what processors we support
>> and many other options.
>>
>> Each structure is entirely different so we have to define a different
>> struct for each one, but that's OK.
>>
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>
> Series applied to powerpc next.
>
> https://git.kernel.org/powerpc/c/d03d1d65b5570ab6fba462a09c2b32
>

Thanks, I'll rebase and repost my changes on top of this

Balbir
