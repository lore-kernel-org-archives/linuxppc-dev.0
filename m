Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 771C71A0103
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 18:38:11 +1000 (AEST)
In-Reply-To: <1437387298-10668-1-git-send-email-weiyang@linux.vnet.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc/powernv: Fix the log message when disabling VF
Message-Id: <20150820083811.64B5E140291@ozlabs.org>
Date: Thu, 20 Aug 2015 18:38:11 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-20-07 at 10:14:58 UTC, Wei Yang wrote:
> On powernv platform, IOV BAR would be shifted if necessary. While the log
> message is not correct when disabling VFs.
> 
> This patch fixes this by print correct message based on the offset value.
> 
> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/74703cc4e08372b8aedf

cheers
