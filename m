Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-we0-x22b.google.com (mail-we0-x22b.google.com
 [IPv6:2a00:1450:400c:c03::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8EAD41A0352
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Mar 2015 17:31:52 +1100 (AEDT)
Received: by wevm14 with SMTP id m14so50825702wev.13
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Mar 2015 22:31:47 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Thu, 5 Mar 2015 07:31:43 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v3 8/8] x86: switch to using asm-generic for seccomp.h
Message-ID: <20150305063143.GA23023@gmail.com>
References: <1425518828-16017-1-git-send-email-keescook@chromium.org>
 <1425518828-16017-9-git-send-email-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1425518828-16017-9-git-send-email-keescook@chromium.org>
Cc: linux-mips@linux-mips.org, Peter Zijlstra <peterz@infradead.org>,
 Will Deacon <will.deacon@arm.com>, Paul Mackerras <paulus@samba.org>,
 sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
 Russell King <linux@arm.linux.org.uk>, Helge Deller <deller@gmx.de>,
 x86@kernel.org, "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Ingo Molnar <mingo@redhat.com>, Frederic Weisbecker <fweisbec@gmail.com>,
 James Hogan <james.hogan@imgtec.com>, Laura Abbott <lauraa@codeaurora.org>,
 Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org,
 Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
 Daniel Borkmann <dborkman@redhat.com>, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Kees Cook <keescook@chromium.org> wrote:

> Switch to using the newly created asm-generic/seccomp.h for the 
> seccomp strict mode syscall definitions. The obsolete sigreturn 
> syscall override is retained in 32-bit mode, and the ia32 syscall 
> overrides are used in the compat case. Remaining definitions were 
> identical.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
