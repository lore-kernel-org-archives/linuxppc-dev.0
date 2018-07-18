Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41VnMm4jvLzF3Hc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2018 16:30:44 +1000 (AEST)
Date: Wed, 18 Jul 2018 16:29:27 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Nicholas Mc Guire <hofrat@osadl.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, kvm-ppc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: PPC: Book3S HV: fix constant size warning
Message-ID: <20180718062927.GC27453@fergus>
References: <1530954445-6780-1-git-send-email-hofrat@osadl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1530954445-6780-1-git-send-email-hofrat@osadl.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jul 07, 2018 at 11:07:25AM +0200, Nicholas Mc Guire wrote:
>  The constants are 64bit but not explicitly declared UL resulting
> in sparse warnings. Fixed by declaring the constants UL.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>

Thanks, patch applied to my kvm-ppc-next branch.

Paul.
