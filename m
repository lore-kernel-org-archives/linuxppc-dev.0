Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 51FD4DDD01
	for <linuxppc-dev@ozlabs.org>; Sun, 24 Feb 2008 16:30:18 +1100 (EST)
Message-ID: <47C100E3.90108@garzik.org>
Date: Sun, 24 Feb 2008 00:30:11 -0500
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH] sata_fsl: fix build with ATA_VERBOSE_DEBUG
References: <20080222165425.GA27460@localhost.localdomain>
In-Reply-To: <20080222165425.GA27460@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
> This patch fixes build and few warnings when ATA_VERBOSE_DEBUG
> is defined:
> 
>   CC      drivers/ata/sata_fsl.o
> drivers/ata/sata_fsl.c: In function ‘sata_fsl_fill_sg’:
> drivers/ata/sata_fsl.c:338: warning: format ‘%x’ expects type ‘unsigned int’, but argument 3 has type ‘void *’
> drivers/ata/sata_fsl.c:338: warning: format ‘%x’ expects type ‘unsigned int’, but argument 4 has type ‘struct prde *’
> drivers/ata/sata_fsl.c: In function ‘sata_fsl_qc_issue’:
> drivers/ata/sata_fsl.c:459: error: ‘csr_base’ undeclared (first use in this function)
> drivers/ata/sata_fsl.c:459: error: (Each undeclared identifier is reported only once
> drivers/ata/sata_fsl.c:459: error: for each function it appears in.)
> drivers/ata/sata_fsl.c: In function ‘sata_fsl_freeze’:
> drivers/ata/sata_fsl.c:525: error: ‘csr_base’ undeclared (first use in this function)
> make[2]: *** [drivers/ata/sata_fsl.o] Error 1
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>  drivers/ata/sata_fsl.c |    8 +++++---
>  1 files changed, 5 insertions(+), 3 deletions(-)

applied
