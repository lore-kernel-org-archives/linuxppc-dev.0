Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vs9gB2pqjzDq7d
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Mar 2017 21:46:14 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: fenghua.yu@intel.com, tony.luck@intel.com, linux-ia64@vger.kernel.org,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>, dyoung@redhat.com,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, vgoyal@redhat.com
Subject: Re: [RESEND PATCH v4 3/5] powerpc/fadump: remove dependency with
 CONFIG_KEXEC
In-Reply-To: <149035343956.6881.1536459326017709354.stgit@hbathini.in.ibm.com>
References: <149035332237.6881.9486330442785822384.stgit@hbathini.in.ibm.com>
 <149035343956.6881.1536459326017709354.stgit@hbathini.in.ibm.com>
Date: Mon, 27 Mar 2017 21:46:12 +1100
Message-ID: <87shlzdmkr.fsf@concordia.ellerman.id.au>
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

Hari Bathini <hbathini@linux.vnet.ibm.com> writes:

> Now that crashkernel parameter parsing and vmcoreinfo related code is
> moved under CONFIG_CRASH_CORE instead of CONFIG_KEXEC_CORE, remove
> dependency with CONFIG_KEXEC for CONFIG_FA_DUMP. While here, get rid
> of definitions of fadump_append_elf_note() & fadump_final_note()
> functions to reuse similar functions compiled under CONFIG_CRASH_CORE.
>
> Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
> Reviewed-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> ---
>  arch/powerpc/Kconfig               |   10 ++++++----
>  arch/powerpc/include/asm/fadump.h  |    2 ++
>  arch/powerpc/kernel/crash.c        |    2 --
>  arch/powerpc/kernel/fadump.c       |   34 +++-------------------------------
>  arch/powerpc/kernel/setup-common.c |    5 +++++
>  5 files changed, 16 insertions(+), 37 deletions(-)

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
