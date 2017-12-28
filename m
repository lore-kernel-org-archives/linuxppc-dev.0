Return-Path: <SRS0=oC7H=DY=goodmis.org=rostedt@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z6v9M4q4kzDqMZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Dec 2017 02:42:15 +1100 (AEDT)
Date: Thu, 28 Dec 2017 10:42:07 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Ralf
 Baechle <ralf@linux-mips.org>, Arnd Bergmann <arnd@arndb.de>, Heiko
 Carstens <heiko.carstens@de.ibm.com>, Kees Cook <keescook@chromium.org>,
 Will Deacon <will.deacon@arm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Garnier <thgarnie@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 "Serge E. Hallyn" <serge@hallyn.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, Russell King
 <linux@armlinux.org.uk>, Paul Mackerras <paulus@samba.org>, Catalin Marinas
 <catalin.marinas@arm.com>, "David S. Miller" <davem@davemloft.net>, Petr
 Mladek <pmladek@suse.com>, Ingo Molnar <mingo@redhat.com>, James Morris
 <james.l.morris@oracle.com>, Andrew Morton <akpm@linux-foundation.org>,
 Nicolas Pitre <nico@linaro.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, Sergey Senozhatsky
 <sergey.senozhatsky@gmail.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Jessica Yu <jeyu@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v6 5/8] kernel: tracepoints: add support for relative
 references
Message-ID: <20171228104207.117ee0ff@gandalf.local.home>
In-Reply-To: <20171227085033.22389-6-ard.biesheuvel@linaro.org>
References: <20171227085033.22389-1-ard.biesheuvel@linaro.org>
 <20171227085033.22389-6-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 27 Dec 2017 08:50:30 +0000
Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> To avoid the need for relocating absolute references to tracepoint
> structures at boot time when running relocatable kernels (which may
> take a disproportionate amount of space), add the option to emit
> these tables as relative references instead.
> 

I gave this patch a quick skim over. It appears to not modify anything
when CONFIG_HAVE_PREL32_RELOCATIONS is not defined. I haven't
thoroughly reviewed it or tested it. But if it doesn't break anything,
I'm fine giving you an ack.

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

--  Steve
