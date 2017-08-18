Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xYjcd44zMzDr4X
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Aug 2017 22:50:57 +1000 (AEST)
In-Reply-To: <1501076076-1974-6-git-send-email-douly.fnst@cn.fujitsu.com>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>, <linux-kernel@vger.kernel.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: Re: [05/11] powerpc/topology: Remove the unused parent_node() macro
Message-Id: <3xYjcd3Y8Sz9t3p@ozlabs.org>
Date: Fri, 18 Aug 2017 22:50:57 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-07-26 at 13:34:30 UTC, Dou Liyang wrote:
> Commit a7be6e5a7f8d ("mm: drop useless local parameters of
> __register_one_node()") removes the last user of parent_node().
> 
> The parent_node() macro in POWERPC platform is unnecessary.
> 
> Remove it for cleanup.
> 
> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/7baebe54a64af44dc34d0bd51462f0

cheers
