Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 330CE1A017E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jul 2014 00:09:37 +1000 (EST)
Message-ID: <53D6599C.9020404@suse.de>
Date: Mon, 28 Jul 2014 16:09:32 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
Subject: Re: [PATCH] KVM: PPC: BOOK3S: HV: Update compute_tlbie_rb to handle
 16MB base page
References: <1403876103-32459-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1403876103-32459-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 27.06.14 15:35, Aneesh Kumar K.V wrote:
> When calculating the lower bits of AVA field, use the shift
> count based on the base page size. Also add the missing segment
> size and remove stale comment.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Thanks, applied to kvm-ppc-queue.


Alex
