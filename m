Return-Path: <joro@8bytes.org>
Received: from mail.8bytes.org (8bytes.org
 [IPv6:2a01:238:4242:f000:64f:6c43:3523:e535])
 by ozlabs.org (Postfix) with ESMTP id 805222C0168
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 23:02:03 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.8bytes.org (Postfix) with SMTP id E6FFC12B044
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 15:01:56 +0200 (CEST)
Date: Tue, 23 Apr 2013 15:01:54 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Varun Sethi <Varun.Sethi@freescale.com>
Subject: Re: [PATCH 1/3 v2] iommu: Move swap_pci_ref function to pci.h.
Message-ID: <20130423125827.GD2589@8bytes.org>
References: <1366691726-9023-1-git-send-email-Varun.Sethi@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1366691726-9023-1-git-send-email-Varun.Sethi@freescale.com>
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

On Tue, Apr 23, 2013 at 10:05:24AM +0530, Varun Sethi wrote:
> +#ifndef __PCI_H
> +#define __PCI_H

Using __PCI_H is not a wise choice, it has certainly a high risk of a
collision. Anyway, I changed it to __IOMMU_PCI_H and applied the patch.


	Joerg
