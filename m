Return-Path: <luto@amacapital.net>
Received: from mail-ua0-x22a.google.com (mail-ua0-x22a.google.com
 [IPv6:2607:f8b0:400c:c08::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tr5Y23LSwzDq9r
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Dec 2016 12:36:53 +1100 (AEDT)
Received: by mail-ua0-x22a.google.com with SMTP id i68so160173539uad.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Dec 2016 17:36:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161230155634.8692-2-dsafonov@virtuozzo.com>
References: <20161230155634.8692-1-dsafonov@virtuozzo.com>
 <20161230155634.8692-2-dsafonov@virtuozzo.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Fri, 30 Dec 2016 17:36:31 -0800
Message-ID: <CALCETrVsjDqWpF2E4gZKMx4EEFHLYSR+AOX_3BcV3FNPe13pkg@mail.gmail.com>
Subject: Re: [RFC 1/4] mm: remove unused TASK_SIZE_OF()
To: Dmitry Safonov <dsafonov@virtuozzo.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Dmitry Safonov <0x7f454c46@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Ralf Baechle <ralf@linux-mips.org>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 "David S. Miller" <davem@davemloft.net>, Peter Zijlstra <peterz@infradead.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Linux MIPS Mailing List <linux-mips@linux-mips.org>,
 linux-parisc@vger.kernel.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 sparclinux@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 X86 ML <x86@kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Dec 30, 2016 at 7:56 AM, Dmitry Safonov <dsafonov@virtuozzo.com> wrote:
> All users of TASK_SIZE_OF(tsk) have migrated to mm->task_size or
> TASK_SIZE_MAX since:
> commit d696ca016d57 ("x86/fsgsbase/64: Use TASK_SIZE_MAX for
> FSBASE/GSBASE upper limits"),
> commit a06db751c321 ("pagemap: check permissions and capabilities at
> open time"),

I like this.

Reviewed-by: Andy Lutomirski <luto@kernel.org> # for x86
