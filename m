Return-Path: <sam@ravnborg.org>
Received: from asavdk4.altibox.net (asavdk4.altibox.net [109.247.116.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z5BhC2Gd4zDrZN
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Dec 2017 08:14:35 +1100 (AEDT)
Date: Mon, 25 Dec 2017 22:05:03 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Ralf Baechle <ralf@linux-mips.org>, Arnd Bergmann <arnd@arndb.de>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Kees Cook <keescook@chromium.org>, Will Deacon <will.deacon@arm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Garnier <thgarnie@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 "Serge E. Hallyn" <serge@hallyn.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Russell King <linux@armlinux.org.uk>, Paul Mackerras <paulus@samba.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 "David S. Miller" <davem@davemloft.net>,
 Petr Mladek <pmladek@suse.com>, Ingo Molnar <mingo@redhat.com>,
 James Morris <james.l.morris@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, Nicolas Pitre <nico@linaro.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Jessica Yu <jeyu@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v5 1/8] arch: enable relative relocations for arm64,
 power, x86, s390 and x86
Message-ID: <20171225210502.GA635@ravnborg.org>
References: <20171225205440.14575-1-ard.biesheuvel@linaro.org>
 <20171225205440.14575-2-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171225205440.14575-2-ard.biesheuvel@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ard.

On Mon, Dec 25, 2017 at 08:54:33PM +0000, Ard Biesheuvel wrote:
> Before updating certain subsystems to use place relative 32-bit
> relocations in special sections, to save space  and reduce the
> number of absolute relocations that need to be processed at runtime
> by relocatable kernels, introduce the Kconfig symbol and define it
> for some architectures that should be able to support and benefit
> from it.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/Kconfig                    | 10 ++++++++++
>  arch/arm64/Kconfig              |  1 +

>  arch/arm64/kernel/vmlinux.lds.S |  2 +-
The change to arch/arm64/kernel/vmlinux.lds.S is
not justified in the changelog.
Did you add it by mistake?

	Sam
