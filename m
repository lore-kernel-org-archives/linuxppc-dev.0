Return-Path: <keescook@google.com>
Received: from mail-io0-x22a.google.com (mail-io0-x22a.google.com
 [IPv6:2607:f8b0:4001:c06::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yGf9S6XS9zDqF9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 02:23:56 +1100 (AEDT)
Received: by mail-io0-x22a.google.com with SMTP id e89so2657329ioi.11
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 08:23:55 -0700 (PDT)
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <87r2u2hs9t.fsf@concordia.ellerman.id.au>
References: <20171016234710.GA102273@beast>
 <20171017125204.728b3a95@roar.ozlabs.ibm.com>
 <87r2u2hs9t.fsf@concordia.ellerman.id.au>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 17 Oct 2017 08:23:53 -0700
Message-ID: <CAGXu5jKt6pypVhxMEv9LYsYvF_P=u3SOK=Yc268wS+oYOHiH=g@mail.gmail.com>
Subject: Re: [PATCH] powerpc/watchdog: Convert timers to use timer_setup()
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
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

On Tue, Oct 17, 2017 at 5:29 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Nicholas Piggin <npiggin@gmail.com> writes:
>
>> On Mon, 16 Oct 2017 16:47:10 -0700
>> Kees Cook <keescook@chromium.org> wrote:
>>
>>> In preparation for unconditionally passing the struct timer_list pointer to
>>> all timer callbacks, switch to using the new timer_setup() and from_timer()
>>> to pass the timer pointer explicitly.
>>>
>>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>> Cc: Paul Mackerras <paulus@samba.org>
>>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>>> Cc: Nicholas Piggin <npiggin@gmail.com>
>>> Cc: linuxppc-dev@lists.ozlabs.org
>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>
>> Looks fine to me. Is this intended to be merged via the powerpc tree
>> in the next merge window?
>
> It relies on the new timer_setup(), which is in one of tglx's trees (I
> think). So I expect it to go via that tree.

It's in -rc3, but the timer tree can carry it if you want. Which do you prefer?

-Kees

-- 
Kees Cook
Pixel Security
