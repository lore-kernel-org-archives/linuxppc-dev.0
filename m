Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AA6781A0041
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jun 2014 07:58:42 +1000 (EST)
Message-ID: <538F968D.4040706@suse.de>
Date: Wed, 04 Jun 2014 23:58:37 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
Subject: Re: [PATCH V2] KVM: PPC: BOOK3S: PR: Fix PURR and SPURR emulation
References: <1401880675-31090-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1401880675-31090-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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


On 04.06.14 13:17, Aneesh Kumar K.V wrote:
> We use time base for PURR and SPURR emulation with PR KVM since we
> are emulating a single threaded core. When using time base
> we need to make sure that we don't accumulate time spent in the host
> in PURR and SPURR value.
>
> Also we don't need to emulate mtspr because both the registers are
> hypervisor resource.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Thanks, applied to kvm-ppc-queue.


Alex
