Date: Sun, 27 Jan 2002 11:49:10 -0600
From: Troy Benjegerdes <hozer@drgw.net>
To: Momchil Velikov <velco@fadata.bg>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Broken asm/div64.h macro
Message-ID: <20020127114910.A14725@altus.drgw.net>
References: <20020126103720.Z14725@altus.drgw.net> <87sn8sybcx.fsf@fadata.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87sn8sybcx.fsf@fadata.bg>; from velco@fadata.bg on Sun, Jan 27, 2002 at 12:51:42AM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Jan 27, 2002 at 12:51:42AM +0200, Momchil Velikov wrote:
> >>>>> "Troy" == Troy Benjegerdes <hozer@drgw.net> writes:
>
> Troy> Our div64.h macro is quite broken, and causes printk to not be able to do
> Troy> a long long format.
>
> Troy> Is there a 'fast' generic C algorithm we can replace it with, instead of
> Troy> mucking with ASM?
>
> Hmm, I sent a patchlet to lkml with Subject: [PATCH] 64-bit divide tweaks.
>
> Doesn't it work for you ?

Didn't seee it..

Did you actually try compiling PPC this way??

vsprintf.o(.text+0x494): undefined reference to `__umoddi3'
vsprintf.o(.text+0x494): relocation truncated to fit: R_PPC_REL24
__umoddi3
vsprintf.o(.text+0x4ac): undefined reference to `__udivdi3'
vsprintf.o(.text+0x4ac): relocation truncated to fit: R_PPC_REL24
__udivdi3

--
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's
why I draw cartoons. It's my life." -- Charles Schulz

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
