Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yGZHz0BdwzDrG0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 23:29:19 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, Kees Cook <keescook@chromium.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/watchdog: Convert timers to use timer_setup()
In-Reply-To: <20171017125204.728b3a95@roar.ozlabs.ibm.com>
References: <20171016234710.GA102273@beast>
 <20171017125204.728b3a95@roar.ozlabs.ibm.com>
Date: Tue, 17 Oct 2017 23:29:18 +1100
Message-ID: <87r2u2hs9t.fsf@concordia.ellerman.id.au>
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

Nicholas Piggin <npiggin@gmail.com> writes:

> On Mon, 16 Oct 2017 16:47:10 -0700
> Kees Cook <keescook@chromium.org> wrote:
>
>> In preparation for unconditionally passing the struct timer_list pointer to
>> all timer callbacks, switch to using the new timer_setup() and from_timer()
>> to pass the timer pointer explicitly.
>> 
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Nicholas Piggin <npiggin@gmail.com>
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>
> Looks fine to me. Is this intended to be merged via the powerpc tree
> in the next merge window?

It relies on the new timer_setup(), which is in one of tglx's trees (I
think). So I expect it to go via that tree.

cheers
