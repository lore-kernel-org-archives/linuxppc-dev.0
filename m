Return-Path: <ard.biesheuvel@linaro.org>
Received: from mail-it0-x232.google.com (mail-it0-x232.google.com
 [IPv6:2607:f8b0:4001:c0b::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zzgml4zBXzDrM8
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Mar 2018 23:44:39 +1100 (AEDT)
Received: by mail-it0-x232.google.com with SMTP id k79-v6so8069182ita.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Mar 2018 05:44:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180311123815.17916-1-ard.biesheuvel@linaro.org>
References: <20180311123815.17916-1-ard.biesheuvel@linaro.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Sun, 11 Mar 2018 12:44:36 +0000
Message-ID: <CAKv+Gu9X7THvdZtoshSQbYGmAHvi+TdaqiM9ienASG-3-Zv88w@mail.gmail.com>
Subject: Re: [PATCH v8 0/6] add support for relative references in special
 sections
To: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
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
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Jessica Yu <jeyu@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
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

On 11 March 2018 at 12:38, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
...
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Thomas Garnier <thgarnie@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: James Morris <james.l.morris@oracle.com>

Note when replying: this ^^^ email address no longer works.

> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Nicolas Pitre <nico@linaro.org>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Jessica Yu <jeyu@kernel.org>
>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: x86@kernel.org
>
...
