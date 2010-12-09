Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (mail.lixom.net [70.86.134.90])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 47B65B70E7
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Dec 2010 18:15:56 +1100 (EST)
Date: Thu, 9 Dec 2010 01:07:58 -0600
From: Olof Johansson <olof@lixom.net>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] powerpc: iommu: Add device name to iommu error printks
Message-ID: <20101209070758.GA14368@lixom.net>
References: <20101208113605.38ac68a9@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20101208113605.38ac68a9@kryten>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 08, 2010 at 11:36:05AM +1100, Anton Blanchard wrote:
> 
> Right now its difficult to see which device is running out of iommu space:
> 
> iommu_alloc failed, tbl c00000076e096660 vaddr c000000768806600 npages 1
> 
> Use dev_info() so we get the device name and location:
> 
> ipr 0000:00:01.0: iommu_alloc failed, tbl c00000076e096660 vaddr c000000768806600 npages 1
> 
> Signed-off-by: Anton Blanchard <anton@samba.org> 

Acked-by: Olof Johansson <olof@lixom.net>
