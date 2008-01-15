Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 937DDDDE1E
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2008 06:42:25 +1100 (EST)
Message-ID: <478D0C93.8060204@garzik.org>
Date: Tue, 15 Jan 2008 14:42:11 -0500
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] [POWERPC] pasemi: Move electra-ide to pata_of_platform
References: <20080109190852.GA18827@localhost.localdomain>
	<20080115164033.GA25328@lixom.net>
In-Reply-To: <20080115164033.GA25328@lixom.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Paul Mundt <lethal@linux-sh.org>, linuxppc-dev@ozlabs.org,
	linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson wrote:
> Move electra-ide glue over to the new pata_of_platform framework, and
> add the quirks needed to that driver.
>     
> ---
> 
> Applied with the rest of the patches to pasemi.git for-2.6.25
> 
>  arch/powerpc/platforms/pasemi/electra_ide.c |   96 ----------------------------
>  b/arch/powerpc/configs/pasemi_defconfig     |    4 -
>  b/arch/powerpc/platforms/pasemi/Kconfig     |    9 --
>  b/arch/powerpc/platforms/pasemi/Makefile    |    1 
>  b/drivers/ata/pata_of_platform.c            |   20 ++++-
> 5 files changed, 17 insertions(+), 113 deletions(-)

ACK
