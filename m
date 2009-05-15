Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7564ADE114
	for <linuxppc-dev@ozlabs.org>; Sat, 16 May 2009 04:17:02 +1000 (EST)
Message-ID: <4A0DB196.8010209@garzik.org>
Date: Fri, 15 May 2009 14:16:54 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] sata_fsl: Fix the command description of FSL SATA
	controller
References: <Pine.LNX.4.64.0905140945540.8378@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.64.0905140945540.8378@localhost.localdomain>
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
> From: Dave Liu <daveliu@freescale.com>
> 
> The bit 11 of command description is reserved bit in Freescale
> SATA controller and needs to be set to '1'.  This is needed to
> make sure the last write from the controller to the buffer
> descriptor is seen before an interrupt is raised.
> 
> Signed-off-by: Dave Liu <daveliu@freescale.com>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> 
> Jeff, please pick this up as a bug fix for 2.6.30
> 
>  drivers/ata/sata_fsl.c |    8 +++++---
>  1 files changed, 5 insertions(+), 3 deletions(-)

applied
