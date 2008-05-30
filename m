Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E124CDDE00
	for <linuxppc-dev@ozlabs.org>; Sat, 31 May 2008 08:11:54 +1000 (EST)
Message-ID: <48407BA2.5050103@pobox.com>
Date: Fri, 30 May 2008 18:11:46 -0400
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Add port multiplier (PMP) support in sata_fsl driver
References: <Pine.LNX.4.64.0805200015010.5318@blarg.am.freescale.net>
In-Reply-To: <Pine.LNX.4.64.0805200015010.5318@blarg.am.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, htejun@gmail.com, ashish.kalra@freescale.com,
	linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> From: Ashish Kalra <ashish.kalra@freescale.com>
> 
> PMP support for sata_fsl driver.
> 
> Signed-off-by: Ashish Kalra <ashish.kalra@freescale.com>
> ---
> Jeff,
> 
> The following commit (4c9bf4e799ce06a7378f1196587084802a414c03):
> libata: replace tf_read with qc_fill_rtf for non-SFF drivers
> 
> Broke the sata_fsl.c driver in 2.6.26.  I know the following patch fixes
> the issue, it clearly also adds port multipler support.  I'm not sure if
> you are willing to take that as part of 2.6.26 or not, but the current
> 2.6.26 driver is broken.
> 
> On boot with debug enabled we get something like (w/o this patch):
> 
> spurious interrupt!!, CC = 0x1
> interrupt status 0x1
> xx_scr_read, reg_in = 1
> spurious interrupt!!, CC = 0x1
> interrupt status 0x1
> xx_scr_read, reg_in = 1
> spurious interrupt!!, CC = 0x1
> interrupt status 0x1
> xx_scr_read, reg_in = 1
> 
> .. continues for ever.
> 
> - k
> 
>  drivers/ata/sata_fsl.c |  224 +++++++++++++++++++++++++++++++++++-------------
>  1 files changed, 163 insertions(+), 61 deletions(-)
> 

applied
