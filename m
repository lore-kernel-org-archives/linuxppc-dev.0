Message-Id: <200201290508.OAA07699@mail.highway.ne.jp>
Date: Tue, 29 Jan 2002 14:05:28 +0900 (JST)
From: Kaoru Fukui <k_fukui@highway.ne.jp>
Subject: Re: Broken asm/div64.h macro
To: trini@kernel.crashing.org
Cc: linuxppc-dev@lists.linuxppc.org,
	Momchil Velikov <velco@fadata.bg>, hozer@drgw.net,
	geert@linux-m68k.org
In-Reply-To: <20020129003720.GA25973@opus.bloom.county>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 28 Jan, Tom Rini wrote:
> On Mon, Jan 28, 2002 at 08:45:31PM +0100, Geert Uytterhoeven wrote:
>> On Mon, 28 Jan 2002, Tom Rini wrote:
>> > On Mon, Jan 28, 2002 at 10:16:28AM +0200, Momchil Velikov wrote:
>> > > >>>>> "Kaoru" == Kaoru Fukui <k_fukui@highway.ne.jp> writes:
>> > >
>> > > Kaoru> On 27 Jan, Troy Benjegerdes wrote:
>> > > >> Did you actually try compiling PPC this way??
>> > > >>
>> > > >> vsprintf.o(.text+0x494): undefined reference to `__umoddi3'
>> > > >> vsprintf.o(.text+0x494): relocation truncated to fit: R_PPC_REL24
>> > > >> __umoddi3
>> > > >> vsprintf.o(.text+0x4ac): undefined reference to `__udivdi3'
>> > > >> vsprintf.o(.text+0x4ac): relocation truncated to fit: R_PPC_REL24
>> > > >> __udivdi3
>> > >
>> > > Kaoru> libgcc.a has those libraries.
>> > >
>> > > Yeah, but we don't link with libgcc.a. (which I forgot).
>> >
>> > Er, but isn't it (sort-of) considered a bug if the kernel links with
>> > libgcc.a ?  I think the consensious on l-k would be yes.
>>
>> So you copy the code from the libgcc sources, cfr. arch/m68k/lib/.
>
> Or optimize that, yes.  But linking directly is a no-no. :)

Yes,it's should has the source in the kernel.

However,the other archies(arm,cris,sh) use libgcc.a with static
link.
Those makefiles have
LIBGCC  := $(shell $(CC) $(CFLAGS) --print-libgcc-file-name)

If it's static link, it is same result isn't it?

Kaoru


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
