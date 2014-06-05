Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 772E21A00D3
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jun 2014 21:57:12 +1000 (EST)
Message-ID: <53905B14.5020204@suse.de>
Date: Thu, 05 Jun 2014 13:57:08 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/3] Prepare for in-kernel VFIO DMA operations acceleration
References: <1401953144-19186-1-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1401953144-19186-1-git-send-email-aik@ozlabs.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: kvm@vger.kernel.org, Gleb Natapov <gleb@kernel.org>,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 05.06.14 09:25, Alexey Kardashevskiy wrote:
> This reserves 2 capability numbers.
>
> This implements an extended version of KVM_CREATE_SPAPR_TCE_64 ioctl.
>
> Please advise how to proceed with these patches as I suspect that
> first two should go via Paolo's tree while the last one via Alex Graf's tree
> (correct?).

They would just go via my tree, but only be actually allocated (read: 
mergable to qemu) when they hit Paolo's tree.

In fact, I don't think it makes sense to split them off at all.


Alex
