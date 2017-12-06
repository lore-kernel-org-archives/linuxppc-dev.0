Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ysFqS3vwdzDrKS
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Dec 2017 21:54:28 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, linux-pm@vger.kernel.org
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, viresh.kumar@linaro.org,
 rjw@rjwysocki.net, linux-kernel@vger.kernel.org, huntbag@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, akshay.adiga@linux.vnet.ibm.com
Subject: Re: [PATCH] cpufreq: powernv: Define methods to parse positive &
 negative pstates
In-Reply-To: <1512017018-4857-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1512017018-4857-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Date: Wed, 06 Dec 2017 21:54:27 +1100
Message-ID: <87r2s8dt3w.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com> writes:

> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
>
> Pstates are 8bit values but on POWER8 they are negative and on POWER9
> they are positive. This patch adds helper routines to differentiate
> the sign to read the correct pstate value.

This sounds like it could be a bad bug, but I can't really tell from the
change log. What is the actual impact of not having this patch?

Should it have a Fixes/Cc-stable tag?

cheers
