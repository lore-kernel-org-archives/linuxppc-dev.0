Message-ID: <3BD6AB69.5010704@elsoft.ch>
Date: Wed, 24 Oct 2001 13:52:09 +0200
From: "David =?ISO-8859-1?Q?M=FCller?= (ELSOFT AG)" <d.mueller@elsoft.ch>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] Various patches against linuxppc_dev-2.4.13-pre6
References: <3BD50D4E.6060401@elsoft.ch> <20011023073258.B30012@cpe-24-221-152-185.az.sprintbbd.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom Rini wrote:

> On Tue, Oct 23, 2001 at 08:25:18AM +0200, David M?ller (ELSOFT AG) wrote:
>
>
>>Hello again
>>
>>The attached patch fixes the following issues:
>>
>>  - arch/ppc/mm/fault.c
>>     missing get_pteptr() prototype
>>
>
> Applied.
>
>
>>  - arch/ppc/kernel/i8259.c
>>     consistent nameing (rather cosmetic change)
>>
>
> Not sure about.  Why either of those changes?
>


The first patch is just a prettyprint fix. At least on my system
it looks better this way ;-)

Everywhere in the i8259.[ch] files the chip is called "i8259" with the
exception of one place which is fixed by the second patch. But as
i said, it's more of a cosmetic change.


>
>>  - arch/ppc/ppc_ksyms.c
>>     missing flush_dcache_all() export
>>
>
> This only exists on CONFIG_NOT_CACHE_COHERENT, fixed and applied.
>
>
>>  - arch/ppc/kernel/ppc4xx_setup.c
>>     added "l" format flag to sprintf() to make compiler happy
>>     (cosmetic)
>>
>>  - arch/ppc/kernel/ppc405_pci.c
>>     adjust include file name
>>
>
> Applied.
>
> Thanks!
>
>

Dave


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
