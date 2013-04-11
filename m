Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B669F2C0077
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2013 04:16:48 +1000 (EST)
Subject: Re: [PATCH 2/5 v11] powerpc: Add iommu domain pointer to device
 archdata
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1364500442-20927-3-git-send-email-Varun.Sethi@freescale.com>
Date: Thu, 11 Apr 2013 13:16:27 -0500
Message-Id: <AC9BAE34-A9CB-4A24-A357-0AA7734CE443@kernel.crashing.org>
References: <1364500442-20927-1-git-send-email-Varun.Sethi@freescale.com>
 <1364500442-20927-3-git-send-email-Varun.Sethi@freescale.com>
To: Varun Sethi <Varun.Sethi@freescale.com>
Cc: joro@8bytes.org, stuart.yoder@freescale.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, scottwood@freescale.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 28, 2013, at 2:53 PM, Varun Sethi wrote:

> Add an iommu domain pointer to device (powerpc) archdata.  Devices
> are attached to iommu domains and this pointer provides a mechanism
> to correlate between a device and the associated iommu domain.  This
> field is set when a device is attached to a domain.
> 
> Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
> ---
> - no change in v11.
> - no change in v10.
> - Added CONFIG_IOMMU_API in v9.
> arch/powerpc/include/asm/device.h |    6 ++++++
> 1 files changed, 6 insertions(+), 0 deletions(-)

Acked-by: Kumar Gala <galak@kernel.crashing.org>

- k
