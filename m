Return-Path: <joro@8bytes.org>
Received: from mail.8bytes.org (8bytes.org [85.214.48.195])
 by ozlabs.org (Postfix) with ESMTP id 40A1B2C00B7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Dec 2013 01:30:08 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.8bytes.org (Postfix) with SMTP id 11EEC12AD4E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Dec 2013 15:18:19 +0100 (CET)
Date: Mon, 30 Dec 2013 15:18:18 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH] iommu: Add empty stub for iommu_group_get_by_id()
Message-ID: <20131230141816.GD2799@8bytes.org>
References: <1385016074-17026-1-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1385016074-17026-1-git-send-email-aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 21, 2013 at 05:41:14PM +1100, Alexey Kardashevskiy wrote:
> Almost every function in include/linux/iommu.h has an empty stub
> but the iommu_group_get_by_id() did not get one by mistake.
> 
> This adds an empty stub for iommu_group_get_by_id() for IOMMU_API
> disabled config.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Applied, thanks.
