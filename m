Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 51B801A1D39
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 12:49:19 +1000 (AEST)
Message-ID: <1439520559.2056.3.camel@ellerman.id.au>
Subject: Re: [PATCH] kvm:powerpc:Fix return statements for wrapper functions
 in the file book3s_64_mmu_hv.c
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alexander Graf <agraf@suse.de>
Cc: Nicholas Krause <xerofoify@gmail.com>, gleb@kernel.org,
 kvm@vger.kernel.org,  linux-kernel@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 pbonzini@redhat.com, linuxppc-dev@lists.ozlabs.org
Date: Fri, 14 Aug 2015 12:49:19 +1000
In-Reply-To: <55CB9927.8050400@suse.de>
References: <1439220451-26094-1-git-send-email-xerofoify@gmail.com>
 <55CB9927.8050400@suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-08-12 at 21:06 +0200, Alexander Graf wrote:
> 
> On 10.08.15 17:27, Nicholas Krause wrote:
> > This fixes the wrapper functions kvm_umap_hva_hv and the function
> > kvm_unmap_hav_range_hv to return the return value of the function
> > kvm_handle_hva or kvm_handle_hva_range that they are wrapped to
> > call internally rather then always making the caller of these
> > wrapper functions think they always run successfully by returning
> > the value of zero directly.
> > 
> > Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
> 
> Paul, could you please take on this one?

Paul's away for a while can you take it directly?

cheers
