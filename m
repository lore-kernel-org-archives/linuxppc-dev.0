Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tPMBy4NhLzDw3Y
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2016 12:32:26 +1100 (AEDT)
Date: Thu, 24 Nov 2016 10:03:32 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 00/11] KVM: PPC: Book3S HV: Support KVM guests on POWER9
Message-ID: <20161123230332.GA21071@fergus.ozlabs.ibm.com>
References: <1479861125-21394-1-git-send-email-paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1479861125-21394-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 23, 2016 at 11:31:54AM +1100, Paul Mackerras wrote:
> This series of patches adds support to HV KVM for running KVM guests
> on POWER9 systems.  This allows us to run KVM guests that use HPT
> (hashed page table) address translation and know about the POWER9
> processor.  With suitable changes to the user-mode driver, this can
> also run guests on POWER9 in POWER8 or POWER7 compatibility mode.
> 
> For now we require the host to be in HPT mode (not radix).
> 
> This series of patches is based on the ppc-kvm topic branch from the
> powerpc tree merged with my current kvm-ppc-next tree.

I have pushed the merge plus this series to my kvm-ppc-next branch.

Paul.
