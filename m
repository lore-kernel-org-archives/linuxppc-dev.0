Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40sjl96qK1zF1s7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 20:52:53 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.ibm.com>
Cc: ego@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, npiggin@gmail.com
Subject: Re: [PATCH] cpuidle/powernv : init all present cpus for deep states
In-Reply-To: <20180517055542.vvpgw2vy2ivowfdc@aksadiga.ibm>
References: <1526472134-23757-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
 <87efiby6a9.fsf@linux.vnet.ibm.com>
 <20180517055542.vvpgw2vy2ivowfdc@aksadiga.ibm>
Date: Fri, 25 May 2018 20:52:53 +1000
Message-ID: <87efi0qa62.fsf@concordia.ellerman.id.au>
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

Akshay Adiga <akshay.adiga@linux.vnet.ibm.com> writes:

> Yes this needs to be sent to  stable. 
>
> Fixes: d405a98c ("powerpc/powernv: Move cpuidle related code from setup.c
> to new file")

Is that really the commit that introduced the bug? :)

Seems like it's more likely this one:

  Fixes: 77b54e9f213f ("powernv/powerpc: Add winkle support for offline cpus")


It's true that because the code was moved in d405a98c we won't be able
to automatically backport the fix past that commit, but we should still
identify the right commit in the Fixes tag.

cheers
