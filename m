Return-Path: <joro@8bytes.org>
Received: from mail.8bytes.org (8bytes.org
 [IPv6:2a01:238:4242:f000:64f:6c43:3523:e535])
 by ozlabs.org (Postfix) with ESMTP id A6F0C2C012F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 23:38:43 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.8bytes.org (Postfix) with SMTP id B52F312AFF0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 15:38:39 +0200 (CEST)
Date: Tue, 23 Apr 2013 15:38:38 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Varun Sethi <Varun.Sethi@freescale.com>
Subject: Re: [PATCH 2/3 v14] iommu/fsl: Add additional iommu attributes
 required by the PAMU driver.
Message-ID: <20130423133837.GG17148@8bytes.org>
References: <1366691726-9023-1-git-send-email-Varun.Sethi@freescale.com>
 <1366691726-9023-2-git-send-email-Varun.Sethi@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1366691726-9023-2-git-send-email-Varun.Sethi@freescale.com>
Cc: stuart.yoder@freescale.com, linux-kernel@vger.kernel.org,
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

On Tue, Apr 23, 2013 at 10:05:25AM +0530, Varun Sethi wrote:
> Added the following domain attributes for the FSL PAMU driver:
> 1. Added new iommu stash attribute, which allows setting of the
>    LIODN specific stash id parameter through IOMMU API.
> 2. Added an attribute for enabling/disabling DMA to a particular
>    memory window.
> 3. Added domain attribute to check for PAMUV1 specific constraints.
> 
> Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
> ---
> v14 changes:
> - Add FSL prefix to PAMU attributes.
> v13 changes:
> - created a new file include/linux/fsl_pamu_stash.h for stash
> attributes.
> v12 changes:
> - Moved PAMU specifc stash ids and structures to PAMU header file.
> - no change in v11.
> - no change in v10.
>  include/linux/fsl_pamu_stash.h |   39 +++++++++++++++++++++++++++++++++++++++

Isn't asm/ for your architecture a better place for that header?


	Joerg
