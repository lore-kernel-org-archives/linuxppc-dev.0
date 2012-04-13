Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AB892B700C
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Apr 2012 01:29:39 +1000 (EST)
Subject: Re: [PATCH] powerpc/e6500: add CPU_FTR_EMB_HV to CPU table
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20120411202752.GA12204@schlenkerla.am.freescale.net>
Date: Fri, 13 Apr 2012 10:29:31 -0500
Message-Id: <2FE08B3F-BC40-4003-84E8-CBF38A8BEB66@kernel.crashing.org>
References: <20120411202752.GA12204@schlenkerla.am.freescale.net>
To: Scott Wood <scottwood@freescale.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 11, 2012, at 3:27 PM, Scott Wood wrote:

> e6500 support (commit 10241842fbe900276634fee8d37ec48a7d8a762f, 
> "powerpc: Add initial e6500 cpu support" and the introduction of
> CPU_FTR_EMB_HV (commit 73196cd364a2d972d73fa08da9d81ca3215bed68,
> "KVM: PPC: e500mc support") collided during merge, leaving e6500's CPU
> table entry missing CPU_FTR_EMB_HV.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> Fixup patch for the KVM merge as requested by Marcelo.
> 
> arch/powerpc/include/asm/cputable.h |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)

Acked-by: Kumar Gala <galak@kernel.crashing.org>

- k
