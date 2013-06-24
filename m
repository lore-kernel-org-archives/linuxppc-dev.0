Return-Path: <joro@8bytes.org>
Received: from mail.8bytes.org (8bytes.org [85.214.48.195])
 by ozlabs.org (Postfix) with ESMTP id 764DE2C051F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jun 2013 20:34:48 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.8bytes.org (Postfix) with SMTP id 4E76812B082
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jun 2013 12:34:38 +0200 (CEST)
Date: Mon, 24 Jun 2013 12:34:35 +0200
From: Joerg Roedel <joro@8bytes.org>
To: alex.williamson@redhat.com, Varun Sethi <Varun.Sethi@freescale.com>
Subject: Re: [PATCH 3/3 v16] iommu/fsl: Freescale PAMU driver and iommu
 implementation.
Message-ID: <20130624103435.GB2778@8bytes.org>
References: <1371744089-17780-1-git-send-email-Varun.Sethi@freescale.com>
 <1371744089-17780-2-git-send-email-Varun.Sethi@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1371744089-17780-2-git-send-email-Varun.Sethi@freescale.com>
Cc: Timur Tabi <timur@tabi.org>, stuart.yoder@freescale.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 20, 2013 at 09:31:28PM +0530, Varun Sethi wrote:
> This patch provides the PAMU driver (fsl_pamu.c) and the corresponding IOMMU
> API implementation (fsl_pamu_domain.c). The PAMU hardware driver (fsl_pamu.c)
> has been derived from the work done by Ashish Kalra and Timur Tabi.

AlexW,

can you please have a look at the group-code again and ack the patch if
it looks right to you?

Thanks,

	Joerg
