Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 37A8C1A000B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Jul 2014 22:21:56 +1000 (EST)
Message-ID: <53B54AE0.5070104@suse.de>
Date: Thu, 03 Jul 2014 14:21:52 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Mihai Caraman <mihai.caraman@freescale.com>, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH 2/6 v2] KVM: PPC: Book3E: Refactor SPE/FP exit handling
References: <1404142497-6430-1-git-send-email-mihai.caraman@freescale.com>
 <1404142497-6430-3-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1404142497-6430-3-git-send-email-mihai.caraman@freescale.com>
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


On 30.06.14 17:34, Mihai Caraman wrote:
> SPE/FP/AltiVec interrupts share the same numbers. Refactor SPE/FP exit handling
> to accommodate AltiVec later on the same flow. Add kvmppc_supports_spe() to detect
> suport for the unit at runtime since it can be configured in the kernel but not
> featured on hardware and vice versa.
>
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>

Why not keep them 100% separate?


Alex
