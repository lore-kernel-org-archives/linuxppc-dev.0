Return-Path: <linus971@gmail.com>
Received: from mail-io0-x241.google.com (mail-io0-x241.google.com
 [IPv6:2607:f8b0:4001:c06::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zzt1M6XYszDqmn
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Mar 2018 07:26:15 +1100 (AEDT)
Received: by mail-io0-x241.google.com with SMTP id p78so9023135iod.13
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Mar 2018 13:26:15 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20180311123815.17916-2-ard.biesheuvel@linaro.org>
References: <20180311123815.17916-1-ard.biesheuvel@linaro.org>
 <20180311123815.17916-2-ard.biesheuvel@linaro.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 11 Mar 2018 13:20:24 -0700
Message-ID: <CA+55aFxcB+5oB_hL83EASOJQrVRCrzT9iS+2+XtEUToG6VHiqA@mail.gmail.com>
Subject: Re: [PATCH v8 1/6] arch: enable relative relocations for arm64, power
 and x86
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>,
 Kees Cook <keescook@chromium.org>, Will Deacon <will.deacon@arm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Thomas Garnier <thgarnie@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, "Serge E. Hallyn" <serge@hallyn.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Russell King <linux@armlinux.org.uk>, Paul Mackerras <paulus@samba.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Petr Mladek <pmladek@suse.com>,
 Ingo Molnar <mingo@redhat.com>, James Morris <james.l.morris@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, Nicolas Pitre <nico@linaro.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Jessica Yu <jeyu@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Mar 11, 2018 at 5:38 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> Before updating certain subsystems to use place relative 32-bit
> relocations in special sections, to save space and reduce the
> number of absolute relocations that need to be processed at runtime
> by relocatable kernels, introduce the Kconfig symbol and define it
> for some architectures that should be able to support and benefit
> from it.

Are there actually architectures hat _don't_ support those relative
32-bit relocations? That really feels pretty fundamental.

I would have expected all of them to do it - is your selection of
arm64/powerpc/x86 perhaps more about "I have tested these" than about
anything else?

Because I'd almost prefer to just do the switch-over unconditionally
if that is at all possible?

             Linus
