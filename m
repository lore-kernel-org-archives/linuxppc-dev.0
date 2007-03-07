Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3F8E8DDF2F
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Mar 2007 07:01:49 +1100 (EST)
In-Reply-To: <1173292541.23776.125.camel@ld0161-tx32>
References: <1173292541.23776.125.camel@ld0161-tx32>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E122D060-AA41-48DE-AC44-CF7714EBAD53@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Do not skip PCI Express to PCI bridge when scanning OF
	node
Date: Wed, 7 Mar 2007 14:00:52 -0600
To: Jon Loeliger <jdl@freescale.com>, Haiying Wang <haiying.wang@freescale.com>
Cc: "linuxppc-dev@ozlabs.org Dev ML" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 7, 2007, at 12:35 PM, Jon Loeliger wrote:

> From: Haiying Wang <haiying.wang@freescale.com>
>
> Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
> Signed-off-by: Haiying Wang <haiying.wang@freescale.com>
> Signed-off-by: Jon Loeliger <jdl@freescale.com>

The signed-off-by's are out of order if this patch is really from  
Haiyang.

Also, I think a better description about why this was needed should  
be provided.  I'm guessing devices behind a PCI Ex to PCI bridge end  
up pdev->bus->self set?  Seems like a bug in the generic pci code.

- k
