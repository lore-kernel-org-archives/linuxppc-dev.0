Return-Path: <joro@8bytes.org>
Received: from mail.8bytes.org (8bytes.org [85.214.48.195])
 by ozlabs.org (Postfix) with ESMTP id C03632C0089
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jun 2013 00:15:49 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.8bytes.org (Postfix) with SMTP id 302B112B0EF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 16:05:13 +0200 (CEST)
Date: Thu, 20 Jun 2013 16:05:11 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Varun Sethi <Varun.Sethi@freescale.com>
Subject: Re: [PATCH 1/2 v15] iommu/fsl: Add additional iommu attributes
 required by the PAMU driver.
Message-ID: <20130620140511.GT2575@8bytes.org>
References: <1366803351-17429-1-git-send-email-Varun.Sethi@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1366803351-17429-1-git-send-email-Varun.Sethi@freescale.com>
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

Varun,

On Wed, Apr 24, 2013 at 05:05:50PM +0530, Varun Sethi wrote:
> Added the following domain attributes for the FSL PAMU driver:
> 1. Added new iommu stash attribute, which allows setting of the
>    LIODN specific stash id parameter through IOMMU API.
> 2. Added an attribute for enabling/disabling DMA to a particular
>    memory window.
> 3. Added domain attribute to check for PAMUV1 specific constraints.
> 
> Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>

Can you please rebase the driver tp v3.10-rc6 and resend asap? I will
give it another review then and request AlexW to look over the
iommu-group stuff. So we can probably get this merged for v3.11.


Thank,

	Joerg
