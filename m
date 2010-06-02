Return-Path: <mtosatti@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 89845B7D2D
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jun 2010 02:27:49 +1000 (EST)
Date: Wed, 2 Jun 2010 13:00:30 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] KVM: PPC: elide struct thread_struct instances from stack
Message-ID: <20100602160030.GB23214@amt.cnet>
References: <m26323onam.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <m26323onam.fsf@igel.home>
Cc: linuxppc-dev@ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
	Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 31, 2010 at 09:59:13PM +0200, Andreas Schwab wrote:
> Instead of instantiating a whole thread_struct on the stack use only the
> required parts of it.
> 
> Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
> Tested-by: Alexander Graf <agraf@suse.de>
> ---
>  arch/powerpc/include/asm/kvm_fpu.h       |   27 +++++----
>  arch/powerpc/kernel/ppc_ksyms.c          |    4 -
>  arch/powerpc/kvm/book3s.c                |   49 +++++++++-------
>  arch/powerpc/kvm/book3s_paired_singles.c |   94 ++++++++++++------------------
>  arch/powerpc/kvm/fpu.S                   |   18 ++++++
>  5 files changed, 97 insertions(+), 95 deletions(-)

Applied, thanks.
