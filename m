Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 522BD2C007E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2012 00:09:25 +1100 (EST)
Subject: Re: [PATCH][V3] powerpc/fsl-pci: Add PCI controller ATMU PM support
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1352340667-11184-1-git-send-email-B38951@freescale.com>
Date: Sun, 25 Nov 2012 07:07:36 -0600
Message-Id: <1BF818F6-565B-494D-9DE2-3540921DCDFC@kernel.crashing.org>
References: <1352340667-11184-1-git-send-email-B38951@freescale.com>
To: Jia Hongtao <B38951@freescale.com>
Cc: B07421@freescale.com, linuxppc-dev@lists.ozlabs.org, B04825@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 7, 2012, at 8:11 PM, Jia Hongtao wrote:

> Power supply for PCI controller ATMU registers is off when system go to
> deep-sleep state. So ATMU registers should be re-setup during PCI
> controllers resume from sleep.
> 
> Signed-off-by: Jia Hongtao <B38951@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> arch/powerpc/sysdev/fsl_pci.c |   37 +++++++++++++++++++++++++++++++++++--
> 1 files changed, 35 insertions(+), 2 deletions(-)

applied to next

- k
