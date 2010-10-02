Return-Path: <jwboyer@gmail.com>
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com
	[74.125.82.170]) by ozlabs.org (Postfix) with ESMTP id 31AA5B6F10
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Oct 2010 11:31:31 +1000 (EST)
Received: by wya21 with SMTP id 21so608099wya.15
	for <linuxppc-dev@ozlabs.org>; Fri, 01 Oct 2010 18:31:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201010012112.o91LCtEk020866@imap1.linux-foundation.org>
References: <201010012112.o91LCtEk020866@imap1.linux-foundation.org>
Date: Fri, 1 Oct 2010 21:31:29 -0400
Message-ID: <AANLkTikrgu5LrYfveax_EavObThNw2M4ukVB3ka1y0Hj@mail.gmail.com>
Subject: Re: [patch 1/1] powerpc: enable ARCH_DMA_ADDR_T_64BIT with
	ARCH_PHYS_ADDR_T_64BIT
From: Josh Boyer <jwboyer@gmail.com>
To: akpm@linux-foundation.org
Content-Type: text/plain; charset=ISO-8859-1
Cc: fujita.tomonori@lab.ntt.co.jp, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 1, 2010 at 5:12 PM,  <akpm@linux-foundation.org> wrote:
> From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>
> =A0arch/powerpc/Kconfig | =A0 =A03 +++
> =A01 file changed, 3 insertions(+)
>
> diff -puN arch/powerpc/Kconfig~powerpc-enable-arch_dma_addr_t_64bit-with-=
arch_phys_addr_t_64bit arch/powerpc/Kconfig
> --- a/arch/powerpc/Kconfig~powerpc-enable-arch_dma_addr_t_64bit-with-arch=
_phys_addr_t_64bit
> +++ a/arch/powerpc/Kconfig
> @@ -16,6 +16,9 @@ config WORD_SIZE
> =A0config ARCH_PHYS_ADDR_T_64BIT
> =A0 =A0 =A0 =A0def_bool PPC64 || PHYS_64BIT
>
> +config ARCH_DMA_ADDR_T_64BIT
> + =A0 =A0 =A0 def_bool ARCH_PHYS_ADDR_T_64BIT
> +

I seemed to have missed what this is about entirely.  Is there some
place I can look that describes what that is supposed to do?  The PPC
4xx boards set PHYS_ADDR_T_64BIT because the MMU uses 36 bit
addressing, but the CPU is only 32 bits.  I want to make sure this DMA
thing isn't going to cause problems.

josh
