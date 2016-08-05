Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s5Hdn1XnmzDqQ1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Aug 2016 16:56:13 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/xics: Properly set Edge/Level type and enable
 resend
In-Reply-To: <1470303695.12584.142.camel@kernel.crashing.org>
References: <1470105583.12584.5.camel@kernel.crashing.org>
 <87twf1f8pj.fsf@concordia.ellerman.id.au>
 <1470303695.12584.142.camel@kernel.crashing.org>
Date: Fri, 05 Aug 2016 16:56:12 +1000
Message-ID: <87vazfiu0j.fsf@concordia.ellerman.id.au>
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

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Thu, 2016-08-04 at 14:40 +1000, Michael Ellerman wrote:
>> > Finally now that edge interrupts are properly identified, we can enable
>> > CONFIG_HARDIRQS_SW_RESEND which will make the core re-send them if
>> > they occur while masked, which some drivers rely upon.
>> >
>> > This fixes issues with lost interrupts on some Mellanox adapters.
>> >
>> > > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> 
>> Broken since forever?
>> 
>> Cc stable?
>
> Broken since forever but I want a bit more testing before that goes to
> stable. Some drivers like Mellanox had a workaround but they want to
> remove it.

OK.

I've put it in fixes-test (should end up in fixes), and added it to my
"probably for stable" list:

  https://github.com/linuxppc/linux/issues/51


cheers
