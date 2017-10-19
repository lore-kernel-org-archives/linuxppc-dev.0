Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHW295NDlzDqBd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 12:05:37 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Kees Cook <keescook@chromium.org>
Cc: Paul Mackerras <paulus@samba.org>,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Nicholas Piggin <npiggin@gmail.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] powerpc/watchdog: Convert timers to use timer_setup()
In-Reply-To: <87zi8ohcgu.fsf@concordia.ellerman.id.au>
References: <20171016234710.GA102273@beast>
 <20171017125204.728b3a95@roar.ozlabs.ibm.com>
 <87r2u2hs9t.fsf@concordia.ellerman.id.au>
 <CAGXu5jKt6pypVhxMEv9LYsYvF_P=u3SOK=Yc268wS+oYOHiH=g@mail.gmail.com>
 <87zi8ohcgu.fsf@concordia.ellerman.id.au>
Date: Thu, 19 Oct 2017 12:05:37 +1100
Message-ID: <87shegj6am.fsf@concordia.ellerman.id.au>
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

Michael Ellerman <mpe@ellerman.id.au> writes:
> Kees Cook <keescook@chromium.org> writes:
>> On Tue, Oct 17, 2017 at 5:29 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>>> Nicholas Piggin <npiggin@gmail.com> writes:
>>>> On Mon, 16 Oct 2017 16:47:10 -0700
>>>> Kees Cook <keescook@chromium.org> wrote:
>>>>> In preparation for unconditionally passing the struct timer_list pointer to
>>>>> all timer callbacks, switch to using the new timer_setup() and from_timer()
>>>>> to pass the timer pointer explicitly.
>>>>>
>>>>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>>>> Cc: Paul Mackerras <paulus@samba.org>
>>>>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>>>>> Cc: Nicholas Piggin <npiggin@gmail.com>
>>>>> Cc: linuxppc-dev@lists.ozlabs.org
>>>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>>>
>>>> Looks fine to me. Is this intended to be merged via the powerpc tree
>>>> in the next merge window?
>>>
>>> It relies on the new timer_setup(), which is in one of tglx's trees (I
>>> think). So I expect it to go via that tree.
>>
>> It's in -rc3, but the timer tree can carry it if you want. Which do
>> you prefer?
>
> Oh sorry, I assumed it was in only in linux-next.
>
> I'll take this. Thanks.

Ugh, I'm an <expletive deleted>.

My next is based on rc2, so I can't take this.

Can you please pick it up.

cheers
