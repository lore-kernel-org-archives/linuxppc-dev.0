Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B85131A0886
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Aug 2014 21:20:52 +1000 (EST)
Message-ID: <53FDBF11.3030004@suse.de>
Date: Wed, 27 Aug 2014 13:20:49 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 2/2] KVM: PPC: Book3S HV: Add register name when loading
 toc
References: <1408424370-16960-1-git-send-email-mikey@neuling.org>
 <1408424370-16960-2-git-send-email-mikey@neuling.org>
In-Reply-To: <1408424370-16960-2-git-send-email-mikey@neuling.org>
Content-Type: text/plain; charset=windows-1252
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 19.08.14 06:59, Michael Neuling wrote:
> Add 'r' to register name r2 in kvmppc_hv_enter.
> 
> Also update comment at the top of kvmppc_hv_enter to indicate that R2/TOC is
> non-volatile.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Signed-off-by: Paul Mackerras <paulus@samba.org>

Thanks, applied to kvm-ppc-queue.


Alex
