Return-Path: <arndbergmann@gmail.com>
Received: from mail-lf0-x243.google.com (mail-lf0-x243.google.com
 [IPv6:2a00:1450:4010:c07::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 418WYk13BVzF0tR
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jun 2018 23:06:01 +1000 (AEST)
Received: by mail-lf0-x243.google.com with SMTP id n24-v6so8797742lfh.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jun 2018 06:06:01 -0700 (PDT)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20180616005323.7938-1-paul.burton@mips.com>
References: <20180616005323.7938-1-paul.burton@mips.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 18 Jun 2018 15:05:57 +0200
Message-ID: <CAK8P3a2Yz-02On2K2U0+8+tR8RQCQ+KWh7CrtqL9L+FweP+TPQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Resolve -Wattribute-alias warnings from
 SYSCALL_DEFINEx()
To: Paul Burton <paul.burton@mips.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
 Ingo Molnar <mingo@kernel.org>,
 Matthew Wilcox <matthew@wil.cx>, Thomas Gleixner <tglx@linutronix.de>,
 Douglas Anderson <dianders@chromium.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Matthias Kaehlcke <mka@chromium.org>,
 He Zhe <zhe.he@windriver.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michal Marek <michal.lkml@markovi.net>, Khem Raj <raj.khem@gmail.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>, Al Viro <viro@zeniv.linux.org.uk>,
 Stafford Horne <shorne@gmail.com>, Gideon Israel Dsouza <gidisrael@gmail.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Kees Cook <keescook@chromium.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jun 16, 2018 at 2:53 AM, Paul Burton <paul.burton@mips.com> wrote:
> This series introduces infrastructure allowing compiler diagnostics to
> be disabled or their severity modified for specific pieces of code, with
> suitable abstractions to prevent that code from becoming tied to a
> specific compiler.
>
> This infrastructure is then used to disable the -Wattribute-alias
> warning around syscall definitions, which rely on type mismatches to
> sanitize arguments.
>
> Finally PowerPC-specific #pragma's are removed now that the generic code
> is handling this.
>
> The series takes Arnd's RFC patches & addresses the review comments they
> received. The most notable effect of this series to to avoid warnings &
> build failures caused by -Wattribute-alias when compiling the kernel
> with GCC 8.
>
> Applies cleanly atop master as of 9215310cf13b ("Merge
> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net").
>

Sorry I dropped the ball on this earlier, and thanks a lot for picking
it up again! From what I can tell, your version addresses all issues
I was aware of, so we should merge that.

      Arnd
