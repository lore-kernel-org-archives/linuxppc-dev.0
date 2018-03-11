Return-Path: <linus971@gmail.com>
Received: from mail-it0-x243.google.com (mail-it0-x243.google.com
 [IPv6:2607:f8b0:4001:c0b::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zzvH93230zDrFv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Mar 2018 08:23:16 +1100 (AEDT)
Received: by mail-it0-x243.google.com with SMTP id j7-v6so8932306ita.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Mar 2018 14:23:16 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CAKv+Gu_E8mVqaR9OmzP2whc7WHGaFX5ypCh7F0UHEyY1DY_t3Q@mail.gmail.com>
References: <20180311123815.17916-1-ard.biesheuvel@linaro.org>
 <20180311123815.17916-2-ard.biesheuvel@linaro.org>
 <CA+55aFxcB+5oB_hL83EASOJQrVRCrzT9iS+2+XtEUToG6VHiqA@mail.gmail.com>
 <CAKv+Gu_E8mVqaR9OmzP2whc7WHGaFX5ypCh7F0UHEyY1DY_t3Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 11 Mar 2018 14:23:12 -0700
Message-ID: <CA+55aFwTUY5s6nh+bmmDyVEoz6ntt5OgdduKUbTnMn5e0q8Y3A@mail.gmail.com>
Subject: Re: [PATCH v8 1/6] arch: enable relative relocations for arm64, power
 and x86
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Arnd Bergmann <arnd@arndb.de>,
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

On Sun, Mar 11, 2018 at 1:35 PM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> I'm sure all of these architectures define some kind of 32-bit place
> relative relocation in their ELF psABI, and I see how it would be
> cleaner to change everything at once, but I anticipate a long tail of
> issues with toolchains for niche architectures that I have no way to
> test.

Ok, fair enough.

           Linus
