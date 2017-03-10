Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vffMJ0115zDqXh
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Mar 2017 18:40:59 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Daniel Axtens <dja@axtens.net>, "Tobin C. Harding" <me@tobin.cc>,
 linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
 "Tobin C. Harding" <me@tobin.cc>
Subject: Re: [PATCH] powerpc: asm: convert directive .llong to .8byte
In-Reply-To: <87o9xa3sd7.fsf@possimpible.ozlabs.ibm.com>
References: <1489038132-3523-1-git-send-email-me@tobin.cc>
 <87o9xa3sd7.fsf@possimpible.ozlabs.ibm.com>
Date: Fri, 10 Mar 2017 18:40:58 +1100
Message-ID: <87d1dplgtx.fsf@concordia.ellerman.id.au>
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

Daniel Axtens <dja@axtens.net> writes:

> Hi Tobin,
>
>> .llong is an undocumented PPC specific directive. The generic
>> equivalent is .quad, but even better (because it's self describing) is
>> .8byte.
>>
>> Convert directives .llong -> .8byte
>>
>> Signed-off-by: Tobin C. Harding <me@tobin.cc>
>> ---
>>
>> Fixes: issue #33 (github)
>
> Thanks for tackling these!
>
> I have applied your patch to my local tree. I ran `git grep '\.llong'`,
> and found:
>
> tools/testing/selftests/powerpc/switch_endian/switch_endian_test.S: .llong 0x5555AAAA5555AAAA
>
> That file is also handled by mpe and the powerpc tree even though it
> doesn't live in arch/powerpc - could you please change that one as well?

I can do that one when I apply it.

cheers
