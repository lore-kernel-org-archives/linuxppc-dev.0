Return-Path: <joro@8bytes.org>
Received: from mail.8bytes.org (8bytes.org
 [IPv6:2a01:238:4242:f000:64f:6c43:3523:e535])
 by lists.ozlabs.org (Postfix) with ESMTP id 142341A000A
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Jul 2014 18:32:23 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.8bytes.org (Postfix) with SMTP id DB18112B165
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Jul 2014 10:32:17 +0200 (CEST)
Date: Mon, 7 Jul 2014 10:32:17 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Varun Sethi <Varun.Sethi@freescale.com>
Subject: Re: [PATCH 0/3] iommu/fsl: Fixes for the PAMU driver.
Message-ID: <20140707083216.GA1958@8bytes.org>
References: <1403618237-26248-1-git-send-email-Varun.Sethi@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1403618237-26248-1-git-send-email-Varun.Sethi@freescale.com>
Cc: alex.williamson@redhat.com, iommu@lists.linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 24, 2014 at 07:27:14PM +0530, Varun Sethi wrote:
> This patch set contains fixes for the PAMU driver. 
> The patches are based on 3.16-rc1.
> 
> Varun Sethi (3):
>   Fix PAMU window size check. 
>   Fix the device domain attach condition.
>   Fix the error condition during iommu group creation.
> 
>  drivers/iommu/fsl_pamu.c        |    8 ++++----
>  drivers/iommu/fsl_pamu_domain.c |   19 +++++++++----------
>  2 files changed, 13 insertions(+), 14 deletions(-)

Applied to iommu/fixes, thanks.
