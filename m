To: Kaoru Fukui <k_fukui@highway.ne.jp>
Cc: hozer@drgw.net, linuxppc-dev@lists.linuxppc.org
Subject: Re: Broken asm/div64.h macro
References: <200201280141.KAA17879@mail.highway.ne.jp>
From: Momchil Velikov <velco@fadata.bg>
In-Reply-To: <200201280141.KAA17879@mail.highway.ne.jp>
Date: 28 Jan 2002 10:16:28 +0200
Message-ID: <87wuy2c2lf.fsf@fadata.bg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> "Kaoru" == Kaoru Fukui <k_fukui@highway.ne.jp> writes:

Kaoru> On 27 Jan, Troy Benjegerdes wrote:
>> Did you actually try compiling PPC this way??
>>
>> vsprintf.o(.text+0x494): undefined reference to `__umoddi3'
>> vsprintf.o(.text+0x494): relocation truncated to fit: R_PPC_REL24
>> __umoddi3
>> vsprintf.o(.text+0x4ac): undefined reference to `__udivdi3'
>> vsprintf.o(.text+0x4ac): relocation truncated to fit: R_PPC_REL24
>> __udivdi3

Kaoru> libgcc.a has those libraries.

Yeah, but we don't link with libgcc.a. (which I forgot).

I'll do something along the lines of
#ifndef __HAVE_ARCH_DO_DIV
...
#endif

... soon.

Regards,
-velco


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
