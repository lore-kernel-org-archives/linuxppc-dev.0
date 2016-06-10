Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rQndh6TCRzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 13:26:32 +1000 (AEST)
In-Reply-To: <1464860688-2085-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: powerpc/mm/radix: Make the pid unsigned long
Message-Id: <3rQndh2YCRz9sdm@ozlabs.org>
Date: Fri, 10 Jun 2016 13:26:32 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-02-06 at 09:44:48 UTC, "Aneesh Kumar K.V" wrote:
> Semantic Issue: comparison of constant 18446744073709551615 with
> expression of type 'unsigned int' is always false.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Reviewed-by: Balbir Singh <bsingharora@gmail.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/9690c15742688e9cb5ee4aa0b0

cheers
