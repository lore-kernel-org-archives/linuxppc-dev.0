Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tKKY12gGjzDvsF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 23:04:05 +1100 (AEDT)
In-Reply-To: <1454514630-29269-17-git-send-email-b.zolnierkie@samsung.com>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Olof Johansson <olof@lixom.net>, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
Subject: Re: powerpc: disable IDE subsystem in pasemi_defconfig
Message-Id: <3tKKY06RKtz9t1d@ozlabs.org>
Date: Thu, 17 Nov 2016 23:04:04 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-03-02 at 15:50:23 UTC, Bartlomiej Zolnierkiewicz wrote:
> This patch disables deprecated IDE subsystem in pasemi_defconfig
> (no IDE host drivers are selected in this config so there is no valid
> reason to enable IDE subsystem itself).
> 
> Cc: Olof Johansson <olof@lixom.net>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/23bf36cd120f97e85ce089c841197f

cheers
