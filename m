Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4197Q40jV1zF0l6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 23:01:32 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Paul Burton <paul.burton@mips.com>, linux-kbuild@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, linux-mips@linux-mips.org,
 Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>,
 Matthew Wilcox <matthew@wil.cx>, Thomas Gleixner <tglx@linutronix.de>,
 Douglas Anderson <dianders@chromium.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthias Kaehlcke <mka@chromium.org>, He Zhe <zhe.he@windriver.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michal Marek <michal.lkml@markovi.net>, Khem Raj <raj.khem@gmail.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>, Al Viro <viro@zeniv.linux.org.uk>,
 Stafford Horne <shorne@gmail.com>,
 "Gideon Israel Dsouza" <gidisrael@gmail.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Kees Cook <keescook@chromium.org>, Heiko Carstens <heiko.carstens@de.ibm.com>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH 3/3] Revert "powerpc: fix build failure by disabling
 attribute-alias warning in pci_32"
In-Reply-To: <20180616005323.7938-4-paul.burton@mips.com>
References: <20180616005323.7938-1-paul.burton@mips.com>
 <20180616005323.7938-4-paul.burton@mips.com>
Date: Tue, 19 Jun 2018 23:01:27 +1000
Message-ID: <87tvpzvsk8.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Burton <paul.burton@mips.com> writes:
> With SYSCALL_DEFINEx() disabling -Wattribute-alias generically, there's
> no need to duplicate that for PowerPC's pciconfig_iobase syscall.
>
> This reverts commit 415520373975 ("powerpc: fix build failure by
> disabling attribute-alias warning in pci_32").
>
> Signed-off-by: Paul Burton <paul.burton@mips.com>

> ---
>
>  arch/powerpc/kernel/pci_32.c | 4 ----
>  1 file changed, 4 deletions(-)

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
