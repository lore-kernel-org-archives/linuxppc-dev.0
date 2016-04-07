Return-Path: <joro@8bytes.org>
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qgj5g1KM7zDq6T
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Apr 2016 22:46:46 +1000 (AEST)
Date: Thu, 7 Apr 2016 14:46:34 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Andy Fleming <afleming@gmail.com>
Cc: iommu@lists.linux-foundation.org, benh@kernel.crashing.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] powerpc: Fix incorrect PPC32 PAMU dependency
Message-ID: <20160407124634.GA31146@8bytes.org>
References: <1458188144-10331-1-git-send-email-afleming@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1458188144-10331-1-git-send-email-afleming@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 16, 2016 at 11:15:44PM -0500, Andy Fleming wrote:
> The Freescale PAMU can be enabled on both 32 and 64-bit Power
> chips. Commit 477ab7a19cec8409e4e2dd10e7348e4cac3c06e5
> (iommu: Make more drivers depend on COMPILE_TEST)
> restricted PAMU to PPC32. PPC covers both.
> 
> Signed-off-by: Andy Fleming <afleming@gmail.com>
> ---
> 
> v2: Implemented Michael Ellerman's suggestion to clean up the
>     dependency chain

Applied, thanks.
