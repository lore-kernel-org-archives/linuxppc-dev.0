Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rNFdX6KTPzDqFh
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jun 2016 10:17:36 +1000 (AEST)
In-Reply-To: <1464675991-13023-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [1/3] powerpc/mm/radix: Update LPCR only if it is powernv
Message-Id: <3rNFdX5PDzz9t48@ozlabs.org>
Date: Mon,  6 Jun 2016 10:17:36 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-31-05 at 06:26:29 UTC, "Aneesh Kumar K.V" wrote:
> LPCR cannot be updated when running in guest mode.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/d6c886006c948141f24e84aceb

cheers
