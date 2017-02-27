Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vWyCd00HczDqHG
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2017 21:11:09 +1100 (AEDT)
In-Reply-To: <1487740322-17755-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: powerpc/mm/hash: Always clear UPRT and Host Radix bits when
 setting up CPU
Message-Id: <3vWyCc5NYdz9sNC@ozlabs.org>
Date: Mon, 27 Feb 2017 21:11:08 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-02-22 at 05:12:02 UTC, "Aneesh Kumar K.V" wrote:
> We will set LPCR with correct value for radix during int. This make sure we
> start with a sanitized value of LPCR. In case of kexec, cpus can have LPCR
> value based on the previous translation mode we were running.
> 
> Fixes: fe036a0605d60 ("powerpc/64/kexec: Fix MMU cleanup on radix")
> Cc: stable@vger.kernel.org # v4.9+
> Acked-by: Michael Neuling <mikey@neuling.org>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/fda2d27db6eae5c2468f9e4657539b

cheers
