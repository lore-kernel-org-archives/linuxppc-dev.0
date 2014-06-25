Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 507C11A000D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 22:08:17 +1000 (EST)
Message-ID: <53AABBAC.6070400@suse.de>
Date: Wed, 25 Jun 2014 14:08:12 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
Subject: Re: [PATCH V2] KVM: PPC: BOOK3S: HV: Use base page size when comparing
 against slb value
References: <1402858027-11296-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1402858027-11296-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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


On 15.06.14 20:47, Aneesh Kumar K.V wrote:
> With guests supporting Multiple page size per segment (MPSS),
> hpte_page_size returns the actual page size used. Add a new function to
> return base page size and use that to compare against the the page size
> calculated from SLB. Without this patch a hpte lookup can fail since
> we are comparing wrong page size in kvmppc_hv_find_lock_hpte.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Thanks, applied to for-3.16.


Alex
