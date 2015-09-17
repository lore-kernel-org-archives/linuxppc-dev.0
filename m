Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0910D1A04EA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2015 15:13:29 +1000 (AEST)
In-Reply-To: <1442300408-26490-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: powerpc/mm: Recompute hash value after a failed update
Message-Id: <20150917051328.BF189140293@ozlabs.org>
Date: Thu, 17 Sep 2015 15:13:28 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-15-09 at 07:00:08 UTC, "Aneesh Kumar K.V" wrote:
> If we had secondary hash flag set, we ended up modifying hash value in
> the updatepp code path. Hence with a failed updatepp we will be using
> a wrong hash value for the following hash insert. Fix this by
> recomputing hash before insert.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Reviewed-by: Paul Mackerras <paulus@samba.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/36b35d5d807b7e57aff7d08e

cheers
