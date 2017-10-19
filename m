Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHZfz35TpzDqBr
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 14:49:15 +1100 (AEDT)
Date: Thu, 19 Oct 2017 14:46:49 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Thomas Meyer <thomas@m3y3r.de>
Cc: agraf@suse.com, benh@kernel.crashing.org, mpe@ellerman.id.au,
 kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] KVM: PPC: Cocci spatch "vma_pages"
Message-ID: <20171019034649.GC3492@fergus.ozlabs.ibm.com>
References: <1505946334393-568186305-0-diffsplit-thomas@m3y3r.de>
 <1505946334393-1459895492-6-diffsplit-thomas@m3y3r.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1505946334393-1459895492-6-diffsplit-thomas@m3y3r.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 21, 2017 at 12:29:36AM +0200, Thomas Meyer wrote:
> Use vma_pages function on vma object instead of explicit computation.
> Found by coccinelle spatch "api/vma_pages.cocci"
> 
> Signed-off-by: Thomas Meyer <thomas@m3y3r.de>

Thanks, applied to my kvm-ppc-next branch, with the headline "KVM:
PPC: BookE: Use vma_pages function".

Paul.
