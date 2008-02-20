Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 791FEDDFF4
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Feb 2008 03:51:01 +1100 (EST)
Message-ID: <47BC5A6B.1030304@pobox.com>
Date: Wed, 20 Feb 2008 11:50:51 -0500
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] fs_enet: Don't call phy_mii_ioctl() in atomic context.
References: <20080215210804.GA14468@loki.buserror.net>
In-Reply-To: <20080215210804.GA14468@loki.buserror.net>
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

Scott Wood wrote:
> The lock acquisition in fs_ioctl() does not appear to actually be necessary,
> and thus is simply removed.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> This fixes the following bug:
> http://ozlabs.org/pipermail/linuxppc-dev/2008-February/051564.html
> 
>  drivers/net/fs_enet/fs_enet-main.c |    7 +------
>  1 files changed, 1 insertions(+), 6 deletions(-)

applied
