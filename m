Date: Mon, 28 Jan 2002 08:28:13 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Momchil Velikov <velco@fadata.bg>
Cc: Kaoru Fukui <k_fukui@highway.ne.jp>, hozer@drgw.net,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Broken asm/div64.h macro
Message-ID: <20020128152813.GG19960@opus.bloom.county>
References: <200201280141.KAA17879@mail.highway.ne.jp> <87wuy2c2lf.fsf@fadata.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87wuy2c2lf.fsf@fadata.bg>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jan 28, 2002 at 10:16:28AM +0200, Momchil Velikov wrote:
>
> >>>>> "Kaoru" == Kaoru Fukui <k_fukui@highway.ne.jp> writes:
>
> Kaoru> On 27 Jan, Troy Benjegerdes wrote:
> >> Did you actually try compiling PPC this way??
> >>
> >> vsprintf.o(.text+0x494): undefined reference to `__umoddi3'
> >> vsprintf.o(.text+0x494): relocation truncated to fit: R_PPC_REL24
> >> __umoddi3
> >> vsprintf.o(.text+0x4ac): undefined reference to `__udivdi3'
> >> vsprintf.o(.text+0x4ac): relocation truncated to fit: R_PPC_REL24
> >> __udivdi3
>
> Kaoru> libgcc.a has those libraries.
>
> Yeah, but we don't link with libgcc.a. (which I forgot).

Er, but isn't it (sort-of) considered a bug if the kernel links with
libgcc.a ?  I think the consensious on l-k would be yes.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
