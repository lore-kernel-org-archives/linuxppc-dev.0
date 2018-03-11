Return-Path: <keescook@google.com>
Received: from mail-vk0-x236.google.com (mail-vk0-x236.google.com
 [IPv6:2607:f8b0:400c:c05::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zzrH94zhqzDrLc
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Mar 2018 06:08:05 +1100 (AEDT)
Received: by mail-vk0-x236.google.com with SMTP id u200so4985335vke.4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Mar 2018 12:08:04 -0700 (PDT)
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <CAKv+Gu9X7THvdZtoshSQbYGmAHvi+TdaqiM9ienASG-3-Zv88w@mail.gmail.com>
References: <20180311123815.17916-1-ard.biesheuvel@linaro.org>
 <CAKv+Gu9X7THvdZtoshSQbYGmAHvi+TdaqiM9ienASG-3-Zv88w@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Sun, 11 Mar 2018 12:08:00 -0700
Message-ID: <CAGXu5jJSQZJMT1T0a4_yJ1FXCVEy+yhyYF8yLwVvugs8DA=_QA@mail.gmail.com>
Subject: Re: [PATCH v8 0/6] add support for relative references in special
 sections
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Will Deacon <will.deacon@arm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Garnier <thgarnie@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 "Serge E. Hallyn" <serge@hallyn.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Russell King <linux@armlinux.org.uk>,
 Paul Mackerras <paulus@samba.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Petr Mladek <pmladek@suse.com>, Ingo Molnar <mingo@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Nicolas Pitre <nico@linaro.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Jessica Yu <jeyu@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "the arch/x86 maintainers" <x86@kernel.org>, James Morris <jmorris@namei.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Mar 11, 2018 at 5:44 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 11 March 2018 at 12:38, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> Cc: James Morris <james.l.morris@oracle.com>
>
> Note when replying: this ^^^ email address no longer works.

James updated MAINTAINERS to: James Morris <jmorris@namei.org>

-- 
Kees Cook
Pixel Security
