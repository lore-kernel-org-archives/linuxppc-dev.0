Return-Path: <keescook@google.com>
Received: from mail-io0-x22b.google.com (mail-io0-x22b.google.com
 [IPv6:2607:f8b0:4001:c06::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y7MVv69lMzDrS3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Oct 2017 05:58:47 +1100 (AEDT)
Received: by mail-io0-x22b.google.com with SMTP id m16so5850545iod.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Oct 2017 11:58:47 -0700 (PDT)
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <e5dcb727-cd7a-0e19-cf9a-8d2e5dd5f258@c-s.fr>
References: <20171005034505.GA32157@beast>
 <6e6bf9ba-d66c-0bcc-358e-fed97b2ca5cd@c-s.fr>
 <CAGXu5jLx+eMYrehvrT7+3V3Joa6VDAbhkLLDndC5aYLxJGmhYA@mail.gmail.com>
 <e5dcb727-cd7a-0e19-cf9a-8d2e5dd5f258@c-s.fr>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 5 Oct 2017 11:58:44 -0700
Message-ID: <CAGXu5jJ-Hn9cEsHzW2LcshcnWAnrMJCwBN4aw9WSD4y6S+nBJQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Default to enabling STRICT_KERNEL_RWX
To: christophe leroy <christophe.leroy@c-s.fr>
Cc: LKML <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 5, 2017 at 11:57 AM, christophe leroy
<christophe.leroy@c-s.fr> wrote:
>
>
> Le 05/10/2017 =C3=A0 19:30, Kees Cook a =C3=A9crit :
>>
>> On Thu, Oct 5, 2017 at 12:49 AM, Christophe LEROY
>> <christophe.leroy@c-s.fr> wrote:
>>>
>>>
>>>
>>> Le 05/10/2017 =C3=A0 05:45, Kees Cook a =C3=A9crit :
>>>>
>>>>
>>>> When available, CONFIG_KERNEL_RWX should be default-enabled.
>>>
>>>
>>>
>>> On PPC32, this option implies deactivating BATs and/or LTLB mapping of
>>> the
>>> linear kernel address space, hence a significant performance degradatio=
n.
>>>
>>> So at least on PPC32, it should remain unselected by default.
>>
>>
>> Alright, sounds fine to me. Would this be okay?
>>
>> +       select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT if !PPC64
>
>
> You mean
>
> select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT if PPC64
>
> Don't you ?

Oops, yes! :)

-Kees

--=20
Kees Cook
Pixel Security
