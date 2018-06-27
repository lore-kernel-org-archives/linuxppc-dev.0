Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41FpK32xK8zF1Kr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jun 2018 13:28:23 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mathieu Malaterre <malat@debian.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] powerpc/32: Remove left over function prototypes
In-Reply-To: <CA+7wUswdBvm+XCi6r6ewGFuSTAaV9FWmhUyV9vNKatCnurvL-A@mail.gmail.com>
References: <20180408194821.19682-1-malat@debian.org>
 <20180620190038.3250-1-malat@debian.org>
 <87602cfkh5.fsf@concordia.ellerman.id.au>
 <CA+7wUswdBvm+XCi6r6ewGFuSTAaV9FWmhUyV9vNKatCnurvL-A@mail.gmail.com>
Date: Wed, 27 Jun 2018 13:28:22 +1000
Message-ID: <871scs7vs9.fsf@concordia.ellerman.id.au>
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

Mathieu Malaterre <malat@debian.org> writes:
> On Thu, Jun 21, 2018 at 1:27 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>> Mathieu Malaterre <malat@debian.org> writes:
>>
>> > In commit 4aea909eeba3 ("powerpc: Add missing prototypes in setup_32.c")
>>
>> I don't have that commit ^ ?
>>
>> That might be because I squashed some of your fixes together or something?
>
> I am doing an awful lots of mistakes these days. Indeed you've changed
> one of my patch:
>
> https://patchwork.kernel.org/patch/10240997/
>
> This one appeared after a git rebase on my side.
>
>> > diff --git a/arch/powerpc/kernel/setup.h b/arch/powerpc/kernel/setup.h
>> > index 35ca309848d7..829ed66f0a40 100644
>> > --- a/arch/powerpc/kernel/setup.h
>> > +++ b/arch/powerpc/kernel/setup.h
>> > @@ -19,9 +19,6 @@ void irqstack_early_init(void);
>> >  void setup_power_save(void);
>> >  unsigned long __init early_init(unsigned long dt_ptr);
>> >  void __init machine_init(u64 dt_ptr);
>> > -int __init ppc_setup_l2cr(char *str);
>> > -int __init ppc_setup_l3cr(char *str);
>> > -int __init ppc_init(void);
>> >  #else
>> >  static inline void setup_power_save(void) { };
>> >  #endif
>>
>> I have:
>>
>> #ifdef CONFIG_PPC32
>> void setup_power_save(void);
>> #else
>> static inline void setup_power_save(void) { };
>> #endif
>
> Correct.
>
> Sorry for the noise.

OK, no worries. Thanks for persisting.

cheers
