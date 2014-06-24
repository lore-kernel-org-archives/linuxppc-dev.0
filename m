Return-Path: <iamjoonsoo.kim@lge.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CF1D61A02A1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jun 2014 17:01:49 +1000 (EST)
Received: from lgemrelse6q.lge.com (LGEMRELSE6Q.lge.com [156.147.1.121])
 by ozlabs.org (Postfix) with ESMTP id 4D6B414007C
 for <linuxppc-dev@ozlabs.org>; Tue, 24 Jun 2014 17:01:46 +1000 (EST)
Date: Tue, 24 Jun 2014 15:51:27 +0900
From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/kvm: Fix build break with
 CONFIG_KVM_BOOK3S_64_HV=y
Message-ID: <20140624065127.GA4836@js1304-P5Q-DELUXE>
References: <1403591807-9550-1-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1403591807-9550-1-git-send-email-mpe@ellerman.id.au>
Cc: Andrew Morton <akpm@osdl.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org, agraf@suse.de,
 linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 24, 2014 at 04:36:47PM +1000, Michael Ellerman wrote:
> Commit e58e263 "PPC, KVM, CMA: use general CMA reserved area management
> framework" in next-20140624 removed arch/powerpc/kvm/book3s_hv_cma.c but
> neglected to update the Makefile, thus breaking the build.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
> 
> Hi Andrew,
> 
> This is in your akpm-current and is breaking some of the builds for
> powerpc in linux-next. Squashing this fix into the original patch would
> be best for us.
> 

I sent really same patch 10 minutes ago. :)

Thanks.
