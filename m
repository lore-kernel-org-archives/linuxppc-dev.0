Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (unknown [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6F98DDDE38
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Jul 2007 11:15:05 +1000 (EST)
Message-ID: <46942F0A.1010707@garzik.org>
Date: Tue, 10 Jul 2007 21:14:50 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Domen Puncer <domen.puncer@telargo.com>
Subject: Re: [PATCH] pata_mpc52xx: suspend/resume support
References: <20070703082738.GM23294@moe.telargo.com>
In-Reply-To: <20070703082738.GM23294@moe.telargo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-ide@vger.kernel.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Domen Puncer wrote:
> Implement suspend and resume routines for mpc52xx ata driver.
> Tested on Lite5200b with deep-sleep and low-power (not yet in-tree)
> modes.
> 
> 
> Signed-off-by: Domen Puncer <domen.puncer@telargo.com>
> 
> ---
> If anyone cares, I attached ATA_DEBUG messages at the end of patch.
> Should it take almost 5 seconds?
> 
> 
>  drivers/ata/pata_mpc52xx.c |   18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)

applied
