Date: Tue, 23 Oct 2001 07:32:58 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "David M?ller (ELSOFT AG)" <d.mueller@elsoft.ch>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] Various patches against linuxppc_dev-2.4.13-pre6
Message-ID: <20011023073258.B30012@cpe-24-221-152-185.az.sprintbbd.net>
References: <3BD50D4E.6060401@elsoft.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3BD50D4E.6060401@elsoft.ch>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Oct 23, 2001 at 08:25:18AM +0200, David M?ller (ELSOFT AG) wrote:

> Hello again
>
> The attached patch fixes the following issues:
>
>   - arch/ppc/mm/fault.c
>      missing get_pteptr() prototype

Applied.

>   - arch/ppc/kernel/i8259.c
>      consistent nameing (rather cosmetic change)

Not sure about.  Why either of those changes?

>   - arch/ppc/ppc_ksyms.c
>      missing flush_dcache_all() export

This only exists on CONFIG_NOT_CACHE_COHERENT, fixed and applied.

>   - arch/ppc/kernel/ppc4xx_setup.c
>      added "l" format flag to sprintf() to make compiler happy
>      (cosmetic)
>
>   - arch/ppc/kernel/ppc405_pci.c
>      adjust include file name

Applied.

Thanks!

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
