Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1CAAF1A0D30
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jan 2015 17:17:05 +1100 (AEDT)
In-Reply-To: <20150107044237.5803.85825.stgit@mars.in.ibm.com>
To: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc/book3s: Fix the MCE code to use
 CONFIG_KVM_BOOK3S_HV_POSSIBLE
Message-Id: <20150130061704.EE8C21402BA@ozlabs.org>
Date: Fri, 30 Jan 2015 17:17:04 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-07-01 at 04:43:07 UTC, Mahesh Salgaonkar wrote:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> commit id 9975f5e added new config variable CONFIG_KVM_BOOK3S_HV_POSSIBLE
> that helps to select the relevant code in the kernel when HV and PR
> bits are built as separate modules. As part of that commit, all the
> instances of #ifdef CONFIG_KVM_BOOK3S_64_HV was replaced with
> CONFIG_KVM_BOOK3S_HV_POSSIBLE. But the MCE code still depends on
> CONFIG_KVM_BOOK3S_64_HV which is wrong. When HV bits are built as a
> separate module the relevent MCE code gets excluded. This patch fixes
> the MCE code to use CONFIG_KVM_BOOK3S_HV_POSSIBLE.

So what is the symptom? ie. is it fatal or just annoying.

And depending on that, should this go to stable?

cheers
