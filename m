Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1C74DDDE32
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 04:19:19 +1000 (EST)
Message-ID: <4703DD22.3090805@pobox.com>
Date: Wed, 03 Oct 2007 14:19:14 -0400
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH RESEND] [11/11] pasemi_mac: enable iommu support
References: <20071002212421.GA2282@lixom.net>
	<20071002212818.GL2282@lixom.net> <4703D5A5.1080204@pobox.com>
	<20071003180354.GB19319@lixom.net>
In-Reply-To: <20071003180354.GB19319@lixom.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson wrote:
> pasemi_mac: enable iommu support
> 
> Enable IOMMU support for pasemi_mac, but avoid using it on non-partitioned
> systems for performance reasons.
> 
> The user can override this by selecting the PPC_PASEMI_IOMMU_DMA_FORCE
> configuration option.
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>

applied
