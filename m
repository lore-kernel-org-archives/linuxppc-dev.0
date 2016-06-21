Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYTRS475dzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 10:40:52 +1000 (AEST)
In-Reply-To: <1465362594-10437-1-git-send-email-imunsie@au.ibm.com>
To: Ian Munsie <imunsie@au1.ibm.com>, mikey <mikey@neuling.org>,
 linuxppc-dev@lists.ozlabs.org, Frederic Barrat <frederic.barrat@fr.ibm.com>,
 Huy Nguyen <huyn@mellanox.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ian Munsie <imunsie@au1.ibm.com>
Subject: Re: [RFC] cxl: Add support for CAPP DMA mode
Message-Id: <3rYTRR5lxmz9t0h@ozlabs.org>
Date: Tue, 21 Jun 2016 10:40:51 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-08-06 at 05:09:54 UTC, Ian Munsie wrote:
> From: Ian Munsie <imunsie@au1.ibm.com>
> 
> This adds support for using CAPP DMA mode, which is required for XSL
> based cards such as the Mellanox CX4 to function.
> 
> This is currently an RFC as it depends on the corresponding support to
> be merged into skiboot first, which was submitted here:
> http://patchwork.ozlabs.org/patch/625582/
> 
> In the event that the skiboot on the system does not have the above
> support, it will indicate as such in the kernel log and abort the init
> process.
> 
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/b385c9e971468eb8816b267424

cheers
