Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40y86S14HbzDrq6
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Jun 2018 01:54:56 +1000 (AEST)
In-Reply-To: <1526472134-23757-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
To: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>, npiggin@gmail.com,
 ego@linux.vnet.ibm.com
Subject: Re: cpuidle/powernv : init all present cpus for deep states
Message-Id: <40y86R6lD6z9s1w@ozlabs.org>
Date: Sat,  2 Jun 2018 01:54:55 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-05-16 at 12:02:14 UTC, Akshay Adiga wrote:
> Init all present cpus for deep states instead of "all possible" cpus.
> Init fails if the possible cpu is gaurded. Resulting in making only
> non-deep states available for cpuidle/hotplug.
> 
> Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/ac9816dcbab53c57bcf1d7b15370b0

cheers
