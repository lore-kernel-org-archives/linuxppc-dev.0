Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3shWzr5388zDrLj
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Sep 2016 13:00:08 +1000 (AEST)
In-Reply-To: <1471596759-3396-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [V2,
 1/5] powerpc/64/kexec: NULL check "clear_all" in kexec_sequence
Message-Id: <3shWzr4Ndnz9srZ@ozlabs.org>
Date: Sun, 25 Sep 2016 13:00:08 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-19-08 at 08:52:35 UTC, "Aneesh Kumar K.V" wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> With Radix, it can be NULL even on !BOOKE these days so replace
> the ifdef with a NULL check which is cleaner anyway.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Acked-by: Balbir Singh <bsingharora@gmail.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/fc48bad53142c991a5280940fd

cheers
