Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C39501A039D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jun 2014 02:06:18 +1000 (EST)
Message-ID: <53A06777.6020103@suse.de>
Date: Tue, 17 Jun 2014 18:06:15 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>, benh@kernel.crashing.org,
 paulus@samba.org, clg@fr.ibm.com
Subject: Re: [PATCH 4/4] KVM: PPC: Assembly functions exported to modules
 need _GLOBAL_TOC()
References: <20140612181420.65b05675@kryten> <20140612181653.7141a7b8@kryten>
In-Reply-To: <20140612181653.7141a7b8@kryten>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 12.06.14 10:16, Anton Blanchard wrote:
> Both kvmppc_hv_entry_trampoline and kvmppc_entry_trampoline are
> assembly functions that are exported to modules and also require
> a valid r2.
>
> As such we need to use _GLOBAL_TOC so we provide a global entry
> point that establishes the TOC (r2).
>
> Signed-off-by: Anton Blanchard <anton@samba.org>

Thanks, applied to kvm-ppc-queue.

I've not applied patches 1 and 2 for now, as they break BE module support.


Alex
