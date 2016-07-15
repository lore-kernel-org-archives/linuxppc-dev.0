Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rrTvF60qSzDqyb
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 20:53:29 +1000 (AEST)
In-Reply-To: <1468444634-1866-16-git-send-email-imunsie@au.ibm.com>
To: Ian Munsie <imunsie@au1.ibm.com>, Michael Neuling <mikey@neuling.org>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Huy Nguyen <huyn@mellanox.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ian Munsie <imunsie@au1.ibm.com>, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [15/15] cxl: Add cxl_check_and_switch_mode() API to switch
 bi-modal cards
Message-Id: <3rrTvF2S3Jz9sCg@ozlabs.org>
Date: Fri, 15 Jul 2016 20:53:29 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-13-07 at 21:17:14 UTC, Ian Munsie wrote:
> From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> 
> Add a new API, cxl_check_and_switch_mode() to allow for switching of
> bi-modal CAPI cards, such as the Mellanox CX-4 network card.
...
> 
> Co-authored-by: Ian Munsie <imunsie@au1.ibm.com>
> Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
> Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/b0b5e5918ad1babfd1d43d98c7

cheers
