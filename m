Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vzNHz42LyzDqK1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Apr 2017 23:06:07 +1000 (AEST)
In-Reply-To: <1491213104-24450-2-git-send-email-alistair@popple.id.au>
To: Alistair Popple <alistair@popple.id.au>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: devicetree@vger.kernel.org, Alistair Popple <alistair@popple.id.au>,
 mhairgrove@nvidia.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
 robh+dt@kernel.org, shailendras@nvidia.com
Subject: Re: [v2,
 2/3] powerpc/powernv: Add sanity checks to pnv_pci_get_{gpu|npu}_dev
Message-Id: <3vzNHz2TyZz9sCX@ozlabs.org>
Date: Thu,  6 Apr 2017 23:06:07 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-04-03 at 09:51:43 UTC, Alistair Popple wrote:
> The pnv_pci_get_{gpu|npu}_dev functions are used to find associations
> between nvlink PCIe devices and standard PCIe devices. However they
> lacked basic sanity checking which results in NULL pointer
> dereferencing if they are incorrect called can be harder to spot than
> an explicit WARN_ON.
> 
> Signed-off-by: Alistair Popple <alistair@popple.id.au>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/4c3b89effc281704d5395282c800c4

cheers
