Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 11BC1DDF3A
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Nov 2007 07:39:02 +1100 (EST)
Date: Sun, 25 Nov 2007 23:37:06 +0300
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCH resend 2/4] powerpc: kill non-existent symbols from
	ksyms and commproc.h
Message-ID: <20071125233706.3e22871a@kernel.crashing.org>
In-Reply-To: <4745B422.5080103@scram.de>
References: <4745B422.5080103@scram.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 22 Nov 2007 17:53:54 +0100
Jochen Friedrich wrote:

> Remove exports of __res and cpm_install_handler/cpm_free_handler.
> Remove cpm_install_handler/cpm_free_handler from the commproc.h as
> well.  Both were used for ARCH=ppc and aren't defined for
> ARCH=powerpc.
> 
> CC      arch/powerpc/kernel/ppc_ksyms.o
> arch/powerpc/kernel/ppc_ksyms.c:180: error: '__res' undeclared here
> (not in a function) arch/powerpc/kernel/ppc_ksyms.c:180: warning:
> type defaults to 'int' in declaration of '__res' make[1]: ***
> [arch/powerpc/kernel/ppc_ksyms.o] Error 1 make: ***
> [arch/powerpc/kernel] Error 2
> 
> LD      .tmp_vmlinux1
> arch/powerpc/kernel/built-in.o:(__ksymtab+0x198): undefined reference
> to `cpm_free_handler'
> arch/powerpc/kernel/built-in.o:(__ksymtab+0x1a0): undefined reference
> to `cpm_install_handler' make: *** [.tmp_vmlinux1] Error 1
> 
> Signed-off-by: Jochen Friedrich <jochen@scram.de>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Applied to linux-2.6-8xx.git,  for-paulus branch.
-- 
Sincerely, Vitaly
