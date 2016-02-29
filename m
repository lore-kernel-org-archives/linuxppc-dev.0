Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4ACC01A0035
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Feb 2016 22:32:38 +1100 (AEDT)
Date: Mon, 29 Feb 2016 22:30:54 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Alexander Graf <agraf@suse.com>,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH kernel v3 0/7] KVM: PPC: Add in-kernel multitce handling
Message-ID: <20160229113054.GD32418@fergus.ozlabs.ibm.com>
References: <1455501309-47200-1-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1455501309-47200-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 15, 2016 at 12:55:02PM +1100, Alexey Kardashevskiy wrote:
> These patches enable in-kernel acceleration for H_PUT_TCE_INDIRECT and
> H_STUFF_TCE hypercalls which allow doing multiple (up to 512) TCE entries
> update in a single call saving time on switching context. QEMU already
> supports these hypercalls so this is just an optimization.
> 
> Both HV and PR KVM modes are supported.
> 
> This does not affect VFIO, this support is coming next.
> 
> This includes "powerpc: Make vmalloc_to_phys() public" as the patch depends
> on it. The individual patches have changelog.

Series applied to my kvm-ppc-next branch, thanks.

Paul.
