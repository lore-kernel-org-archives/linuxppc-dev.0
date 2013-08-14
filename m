Return-Path: <joro@8bytes.org>
Received: from mail.8bytes.org (8bytes.org
 [IPv6:2a01:238:4242:f000:64f:6c43:3523:e535])
 by ozlabs.org (Postfix) with ESMTP id 6A4122C0190
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2013 20:00:46 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.8bytes.org (Postfix) with SMTP id A74DE12B0E2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2013 11:48:06 +0200 (CEST)
Date: Wed, 14 Aug 2013 11:48:03 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Varun Sethi <Varun.Sethi@freescale.com>
Subject: Re: [PATCH 1/3] powerpc: Add iommu domain pointer to device archdata
Message-ID: <20130814094802.GC4491@8bytes.org>
References: <1373863857-27239-1-git-send-email-Varun.Sethi@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1373863857-27239-1-git-send-email-Varun.Sethi@freescale.com>
Cc: stuart.yoder@freescale.com, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, alex.williamson@redhat.com,
 scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 15, 2013 at 10:20:55AM +0530, Varun Sethi wrote:
> Add an iommu domain pointer to device (powerpc) archdata.  Devices
> are attached to iommu domains and this pointer provides a mechanism
> to correlate between a device and the associated iommu domain.  This
> field is set when a device is attached to a domain.
> 
> Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
> Acked-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> - rebased patch to 3.11-rc1
>  arch/powerpc/include/asm/device.h |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)

Okay, I applied these patches to my ppc/pamu branch. But before I merge
it to my next branch (so that it can go upstream) I want to have a
compile-test-case first. Can you send me a working .config which
includes this driver?

Thanks,

	Joerg
