Return-Path: <ard.biesheuvel@linaro.org>
Received: from mail-it0-x243.google.com (mail-it0-x243.google.com
 [IPv6:2607:f8b0:4001:c0b::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z5XBH2xKFzDqm7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Dec 2017 21:23:18 +1100 (AEDT)
Received: by mail-it0-x243.google.com with SMTP id f190so22399704ita.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Dec 2017 02:23:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <201712261806.hJg043uc%fengguang.wu@intel.com>
References: <20171225205440.14575-7-ard.biesheuvel@linaro.org>
 <201712261806.hJg043uc%fengguang.wu@intel.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 26 Dec 2017 10:23:15 +0000
Message-ID: <CAKv+Gu_9L8LDe72FJDDhWVA4G9ZWcuxQnxWRtFMKgH=AhMOiZQ@mail.gmail.com>
Subject: Re: [PATCH v5 6/8] kernel/jump_label: abstract jump_entry member
 accessors
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Ralf Baechle <ralf@linux-mips.org>, Arnd Bergmann <arnd@arndb.de>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Kees Cook <keescook@chromium.org>,
 Will Deacon <will.deacon@arm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Garnier <thgarnie@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 "Serge E. Hallyn" <serge@hallyn.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Russell King <linux@armlinux.org.uk>,
 Paul Mackerras <paulus@samba.org>, Catalin Marinas <catalin.marinas@arm.com>,
 "David S. Miller" <davem@davemloft.net>, Petr Mladek <pmladek@suse.com>,
 Ingo Molnar <mingo@redhat.com>, James Morris <james.l.morris@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Nicolas Pitre <nico@linaro.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Jessica Yu <jeyu@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 26 December 2017 at 10:19, kbuild test robot <lkp@intel.com> wrote:
> Hi Ard,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.15-rc5 next-20171222]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Ard-Biesheuvel/add-support-for-relative-references-in-special-sections/20171226-164147
> config: s390-allmodconfig (attached as .config)
> compiler: s390x-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=s390
>

I guess the diffstat gives it away:

>  arch/arm/include/asm/jump_label.h     | 27 ++++++++++++++
>  arch/arm64/include/asm/jump_label.h   | 27 ++++++++++++++
>  arch/mips/include/asm/jump_label.h    | 27 ++++++++++++++
>  arch/powerpc/include/asm/jump_label.h | 27 ++++++++++++++
>  arch/s390/include/asm/jump_label.h    | 20 +++++++++++
>  arch/sparc/include/asm/jump_label.h   | 27 ++++++++++++++
>  arch/tile/include/asm/jump_label.h    | 27 ++++++++++++++
>  arch/x86/include/asm/jump_label.h     | 27 ++++++++++++++

Will fix in the next revision.
