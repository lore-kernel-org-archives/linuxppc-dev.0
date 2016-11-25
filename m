Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tPxBf554BzDvk5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2016 11:04:10 +1100 (AEDT)
In-Reply-To: <20161115150606.14090-1-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>, imunsie@au1.ibm.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: powerpc/mm/coproc: Handle bad address on coproc slb fault
Message-Id: <3tPxBf1KLNz9t37@ozlabs.org>
Date: Fri, 25 Nov 2016 11:04:09 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-11-15 at 15:06:06 UTC, "Aneesh Kumar K.V" wrote:
> VSID 0 is bad address. Don't create slb entries on coproc fault for
> bad address
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Reviewed-by: Balbir Singh <bsingharora@gmail.com>
> Reviewed-by: Ian Munsie <imunsie@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/64168f4296fa507ba059307984cddc

cheers
