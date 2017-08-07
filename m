Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xQvGk07Q1zDqnQ
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Aug 2017 20:41:50 +1000 (AEST)
In-Reply-To: <20170112090906.17864-1-rui.teng@linux.vnet.ibm.com>
To: Rui Teng <rui.teng@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Boqun Feng <boqun.feng@gmail.com>, Rui Teng <rui.teng@linux.vnet.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 jia he <hejianet@linux.vnet.ibm.com>
Subject: Re: powerpc/mm: fix a hardcode on memory boundary checking
Message-Id: <3xQvGj6QZMz9t2R@ozlabs.org>
Date: Mon,  7 Aug 2017 20:41:49 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-01-12 at 09:09:06 UTC, Rui Teng wrote:
> The offset of hugepage block will not be 16G, if the expected
> page is more than one. Calculate the totol size instead of the
> hardcode value.
> 
> Signed-off-by: Rui Teng <rui.teng@linux.vnet.ibm.com>
> Tested-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/23493c121912a39f0262e0dbeb236e

cheers
