Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 349FFDDEDF
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Aug 2008 16:11:49 +1000 (EST)
Message-ID: <489A921A.2000906@garzik.org>
Date: Thu, 07 Aug 2008 02:11:38 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Li Yang <leoli@freescale.com>
Subject: Re: [PATCH] net/fs_enet: remove redundant messages for performance
References: <1218006530-27173-1-git-send-email-leoli@freescale.com>
In-Reply-To: <1218006530-27173-1-git-send-email-leoli@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Li Yang wrote:
> Currently when we do a packet flood to the Ethernet port, the console
> reports error every time when a packet is dropped.  This is too
> redundant and cost performance.  Remove message for this type of event.
> 
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
>  drivers/net/fs_enet/mac-fcc.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/net/fs_enet/mac-fcc.c b/drivers/net/fs_enet/mac-fcc.c
> index 0a97fc2..1c7ef81 100644
> --- a/drivers/net/fs_enet/mac-fcc.c
> +++ b/drivers/net/fs_enet/mac-fcc.c
> @@ -126,7 +126,7 @@ out:
>  #define FCC_NAPI_RX_EVENT_MSK	(FCC_ENET_RXF | FCC_ENET_RXB)
>  #define FCC_RX_EVENT		(FCC_ENET_RXF)
>  #define FCC_TX_EVENT		(FCC_ENET_TXB)
> -#define FCC_ERR_EVENT_MSK	(FCC_ENET_TXE | FCC_ENET_BSY)
> +#define FCC_ERR_EVENT_MSK	(FCC_ENET_TXE)
>  

applied
