Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CAC391A0010
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jun 2014 23:39:50 +1000 (EST)
Message-ID: <53A97FA1.4040503@suse.de>
Date: Tue, 24 Jun 2014 15:39:45 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Mihai Caraman <mihai.caraman@freescale.com>, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH] KVM: PPC: Book3E: Unlock mmu_lock when setting caching
 atttribute
References: <1403106305-11565-1-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1403106305-11565-1-git-send-email-mihai.caraman@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Bharat Bhushan <bharat.bhushan@freescale.com>,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 18.06.14 17:45, Mihai Caraman wrote:
> The patch 08c9a188d0d0fc0f0c5e17d89a06bb59c493110f
>    	kvm: powerpc: use caching attributes as per linux pte
> do not handle properly the error case, letting mmu_lock locked. The lock
> will further generate a RCU stall from kvmppc_e500_emul_tlbwe() caller.
>
> In case of an error go to out label.
>
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> Cc: Bharat Bhushan <bharat.bhushan@freescale.com>

Thanks, applied to for-3.16.


Alex
