Return-Path: <mtosatti@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 75DD21007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  2 Nov 2010 04:42:04 +1100 (EST)
Date: Mon, 1 Nov 2010 15:19:49 -0200
From: Marcelo Tosatti <mtosatti@redhat.com>
To: Vasiliy Kulikov <segooon@gmail.com>
Subject: Re: [PATCH] powerpc: kvm: fix information leak to userland
Message-ID: <20101101171949.GB4484@amt.cnet>
References: <1288429464-21763-1-git-send-email-segooon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1288429464-21763-1-git-send-email-segooon@gmail.com>
Cc: kvm@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	Avi Kivity <avi@redhat.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Oct 30, 2010 at 01:04:24PM +0400, Vasiliy Kulikov wrote:
> Structure kvm_ppc_pvinfo is copied to userland with flags and
> pad fields unitialized.  It leads to leaking of contents of
> kernel stack memory.
> 
> Signed-off-by: Vasiliy Kulikov <segooon@gmail.com>
> ---
>  I cannot compile this driver, so it is not tested at all.
> 
>  arch/powerpc/kvm/powerpc.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)

Applied, thanks.
