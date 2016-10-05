Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spfzx19sszDrMD
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 13:36:29 +1100 (AEDT)
In-Reply-To: <1469764534-26948-1-git-send-email-andrew.donnellan@au1.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: clombard@linux.vnet.ibm.com, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, fbarrat@linux.vnet.ibm.com, julia.lawall@lip6.fr,
 imunsie@au1.ibm.com, elfring@users.sourceforge.net
Subject: Re: cxl: replace loop with for_each_child_of_node(),
 remove unneeded of_node_put()
Message-Id: <3spfzw6LSRz9t0t@ozlabs.org>
Date: Wed,  5 Oct 2016 13:36:28 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-29-07 at 03:55:34 UTC, Andrew Donnellan wrote:
> Rewrite the cxl_guest_init_afu() loop in cxl_of_probe() to use
> for_each_child_of_node() rather than a hand-coded for loop.
> 
> Remove the useless of_node_put(afu_np) call after the loop, where it's
> guaranteed that afu_np == NULL.
> 
> Reported-by: SF Markus Elfring <elfring@users.sourceforge.net>
> Reported-by: Julia Lawall <julia.lawall@lip6.fr>
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Reviewed-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/735840b44bcc998e2574faf63d1aaa

cheers
