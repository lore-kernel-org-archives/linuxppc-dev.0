Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3D18FDDE10
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jun 2008 16:18:11 +1000 (EST)
Date: Wed, 4 Jun 2008 08:17:53 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCH] i2c: Add MAINTAINER entry for i2c-cpm.
Message-ID: <20080604081753.6830aca8@hyperion.delvare>
In-Reply-To: <4845A756.6010407@scram.de>
References: <4845A756.6010407@scram.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, Linux I2C <i2c@lm-sensors.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 03 Jun 2008 22:19:34 +0200, Jochen Friedrich wrote:
> Signed-off-by: Jochen Friedrich <jochen@scram.de>
> ---
>  MAINTAINERS |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0a6d2ca..bdfc7bd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1659,6 +1659,13 @@ L:	linux-fbdev-devel@lists.sourceforge.net (moderated for non-subscribers)
>  W:	http://linux-fbdev.sourceforge.net/
>  S:	Maintained
>  
> +FREESCALE I2C CPM DRIVER
> +P:	Jochen Friedrich
> +M:	jochen@scram.de
> +L:	linuxppc-dev@ozlabs.org
> +L:	i2c@lm-sensors.org
> +S:	Maintained
> +
>  FREESCALE DMA DRIVER
>  P:	Li Yang
>  M:	leoli@freescale.com

Applied, thanks.

-- 
Jean Delvare
