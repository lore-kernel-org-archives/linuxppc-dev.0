Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45ABE1A0050
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jul 2014 18:30:18 +1000 (EST)
Message-ID: <53B66616.5080506@suse.de>
Date: Fri, 04 Jul 2014 10:30:14 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Mihai Caraman <mihai.caraman@freescale.com>, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH v2] KVM: PPC: e500: Emulate power management control SPR
References: <1404461848-31999-1-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1404461848-31999-1-git-send-email-mihai.caraman@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 04.07.14 10:17, Mihai Caraman wrote:
> For FSL e6500 core the kernel uses power management SPR register (PWRMGTCR0)
> to enable idle power down for cores and devices by setting up the idle count
> period at boot time. With the host already controlling the power management
> configuration the guest could simply benefit from it, so emulate guest request
> as a general store.
>
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>

Thanks, applied to kvm-ppc-queue.


Alex
