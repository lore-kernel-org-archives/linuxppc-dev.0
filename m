Message-Id: <200201280141.KAA17879@mail.highway.ne.jp>
Date: Mon, 28 Jan 2002 10:38:05 +0900 (JST)
From: Kaoru Fukui <k_fukui@highway.ne.jp>
Subject: Re: Broken asm/div64.h macro
To: hozer@drgw.net
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20020127114910.A14725@altus.drgw.net>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 27 Jan, Troy Benjegerdes wrote:
> Did you actually try compiling PPC this way??
>
> vsprintf.o(.text+0x494): undefined reference to `__umoddi3'
> vsprintf.o(.text+0x494): relocation truncated to fit: R_PPC_REL24
> __umoddi3
> vsprintf.o(.text+0x4ac): undefined reference to `__udivdi3'
> vsprintf.o(.text+0x4ac): relocation truncated to fit: R_PPC_REL24
> __udivdi3

libgcc.a has those libraries.

Kaoru


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
