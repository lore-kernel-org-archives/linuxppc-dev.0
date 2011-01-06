Return-Path: <mtosatti@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id DFB70B7043
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  7 Jan 2011 04:02:16 +1100 (EST)
Date: Thu, 6 Jan 2011 14:39:58 -0200
From: Marcelo Tosatti <mtosatti@redhat.com>
To: Peter Tyser <ptyser@xes-inc.com>
Subject: Re: [PATCH] KVM: PPC: Fix SPRG get/set for Book3S and BookE
Message-ID: <20110106163957.GB8490@amt.cnet>
References: <1293652285-13313-1-git-send-email-ptyser@xes-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1293652285-13313-1-git-send-email-ptyser@xes-inc.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
	agraf@suse.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 29, 2010 at 01:51:25PM -0600, Peter Tyser wrote:
> Previously SPRGs 4-7 were improperly read and written in
> kvm_arch_vcpu_ioctl_get_regs() and kvm_arch_vcpu_ioctl_set_regs();
> 
> Signed-off-by: Peter Tyser <ptyser@xes-inc.com>
> ---
> I noticed this while grepping for somthing unrelated and assume its
> a typo.  Feel free to add to the patch description; I don't use KVM
> so don't know what the high-level consequences of this change are.
> 
>  arch/powerpc/kvm/book3s.c |   14 ++++++++------
>  arch/powerpc/kvm/booke.c  |   14 ++++++++------
>  2 files changed, 16 insertions(+), 12 deletions(-)

Applied, thanks.
