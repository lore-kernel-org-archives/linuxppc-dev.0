Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5A1AEDE105
	for <linuxppc-dev@ozlabs.org>; Sat, 16 May 2009 04:16:50 +1000 (EST)
Message-ID: <4A0DB188.9000708@garzik.org>
Date: Fri, 15 May 2009 14:16:40 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v3] sata_fsl: Fix compile warnings
References: <1242270650-27945-1-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1242270650-27945-1-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> We we build with dma_addr_t as a 64-bit quantity we get:
> 
> drivers/ata/sata_fsl.c: In function 'sata_fsl_fill_sg':
> drivers/ata/sata_fsl.c:340: warning: format '%x' expects type 'unsigned int', but argument 4 has type 'dma_addr_t'
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> * v2: fixed extra 'x'
> * v3: fixed whitespace issue
> 
>  drivers/ata/sata_fsl.c |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)

applied
