Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHTzn096FzDvjR
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 23:17:25 +1100 (AEDT)
In-Reply-To: <20160918110845.akvr46gdpuubo2q2@aragorn.home.lxtec.de>
To: Elimar Riesebieter <riesebie@lxtec.de>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: Removed dependency on IDE_GD_ATA if ADB_PMU_LED_DISK is selected.
Message-Id: <3tHTzm5cpnz9t3K@ozlabs.org>
Date: Mon, 14 Nov 2016 23:17:24 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2016-18-09 at 11:08:45 UTC, Elimar Riesebieter wrote:
> We can use the front led of powerbooks/ibooks as a disk activitiy imagination
> without the deprecated IDE_GD_ATA.
> 
> Signed-off-by: Elimar Riesebieter <riesebie@lxtec.de>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/0e865a80c1358db9311c411c4763b9

cheers
