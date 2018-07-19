Return-Path: <keescook@google.com>
Received: from mail-yb0-x241.google.com (mail-yb0-x241.google.com
 [IPv6:2607:f8b0:4002:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41WjMt1gt5zDqCs
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2018 04:34:00 +1000 (AEST)
Received: by mail-yb0-x241.google.com with SMTP id x15-v6so3656030ybm.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jul 2018 11:34:00 -0700 (PDT)
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <8736wfctdl.fsf@concordia.ellerman.id.au>
References: <20180629185254.GA37557@beast>
 <CAGXu5jKV-YAQZtN2heFdmiD9EOZ-AqrBc-NjC8fRYLSafovuyQ@mail.gmail.com>
 <8736wfctdl.fsf@concordia.ellerman.id.au>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 19 Jul 2018 11:33:57 -0700
Message-ID: <CAGXu5jK+K5Wo2Syf0-b9mWorSSLSj8XbimPtPSayjiMMkWht5A@mail.gmail.com>
Subject: Re: [PATCH] powerpc/msi: Remove VLA usage
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, Rob Herring <robh@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, PowerPC <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 19, 2018 at 5:17 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Kees Cook <keescook@chromium.org> writes:
>
>> On Fri, Jun 29, 2018 at 11:52 AM, Kees Cook <keescook@chromium.org> wrote:
>>> In the quest to remove all stack VLA usage from the kernel[1], this
>>> switches from an unchanging variable to a constant expression to eliminate
>>> the VLA generation.
>>>
>>> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>>>
>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>
>> Friendly ping! Michael, can you take this?
>
> Yep, sorry. I actually applied it weeks ago but hadn't pushed.

No worries! Thanks! :)

-Kees

-- 
Kees Cook
Pixel Security
