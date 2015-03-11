Return-Path: <keescook@google.com>
Received: from mail-vc0-x229.google.com (mail-vc0-x229.google.com
 [IPv6:2607:f8b0:400c:c03::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 569591A078D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 05:59:57 +1100 (AEDT)
Received: by mail-vc0-f169.google.com with SMTP id im6so3762291vcb.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 11:59:55 -0700 (PDT)
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <1425518828-16017-1-git-send-email-keescook@chromium.org>
References: <1425518828-16017-1-git-send-email-keescook@chromium.org>
Date: Wed, 11 Mar 2015 11:59:55 -0700
Message-ID: <CAGXu5j+PMBEPLTLiDVZ9XvnT9a2P+tOGPLXfE865crteeChDFQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] switch to using asm-generic for seccomp.h
From: Kees Cook <keescook@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Cc: Linux MIPS Mailing List <linux-mips@linux-mips.org>,
 Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>,
 Paul Mackerras <paulus@samba.org>, sparclinux <sparclinux@vger.kernel.org>,
 linux-arch <linux-arch@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>,
 Helge Deller <deller@gmx.de>, "x86@kernel.org" <x86@kernel.org>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>, Ingo Molnar <mingo@redhat.com>,
 Frederic Weisbecker <fweisbec@gmail.com>, James Hogan <james.hogan@imgtec.com>,
 Laura Abbott <lauraa@codeaurora.org>, Kees Cook <keescook@chromium.org>,
 Arnd Bergmann <arnd@arndb.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Michal Simek <monstr@monstr.eu>, linux-parisc <linux-parisc@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
 Daniel Borkmann <dborkman@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 4, 2015 at 5:27 PM, Kees Cook <keescook@chromium.org> wrote:
> Most architectures don't need to do much special for the strict-mode
> seccomp syscall entries. Remove the redundant headers and reduce the
> others.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Hi Andrew,

Just a quick ping: are you able to pick up this series, or should I
try to get this in on a per-arch basis?

Thanks!

-Kees

> ---
> v3:
> - split patch series by architecture
> - fix up architectures that need sigreturn overrides (ingo)
> v2:
> - use Kbuild "generic-y" instead of explicit #include lines (sfr)
>



-- 
Kees Cook
Chrome OS Security
