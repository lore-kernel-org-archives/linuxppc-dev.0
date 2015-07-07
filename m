Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 170691A105E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jul 2015 20:38:05 +1000 (AEST)
In-Reply-To: <1436139634-11787-1-git-send-email-dja@axtens.net>
To: Daniel Axtens <dja@axtens.net>, fengguang.wu@intel.com
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, Daniel Axtens <dja@axtens.net>
Subject: Re: powerpc/ppc4xx_hsta_msi: Include ppc-pci.h to fix reference to
 hose_list
Message-Id: <20150707103804.A48A41402C4@ozlabs.org>
Date: Tue,  7 Jul 2015 20:38:04 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2015-05-07 at 23:40:34 UTC, Daniel Axtens wrote:
> An earlier commit referenced 'hose_list' in sysdev/ppc4xx_hsta_msi.c.
> hose_list is defined in ppc-pci.h, which was not included in that
> file. Include it, fixing the build for the akebono defconfig used
> by the kbuild test robot.
> 
> Fixes: f2c800aaceb6 ("powerpc/ppc4xx_hsta_msi: Move MSI-related ops to pci_controller_ops")
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Daniel Axtens <dja@axtens.net>

Applied to powerpc fixes, thanks.

https://git.kernel.org/cgit/linux/kernel/git/powerpc/linux.git/commit/?h=fixes&id=aaf6fd5c75eb4aa734ec2062deab371633c3655f

cheers
