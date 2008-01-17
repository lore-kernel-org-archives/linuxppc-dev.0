Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 64D16DDE48
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 07:54:15 +1100 (EST)
Subject: Re: [PATCH] net: NEWEMAC: Remove "rgmii-interface" from rgmii
	matching table
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <1200476230-14026-1-git-send-email-sr@denx.de>
References: <1200476230-14026-1-git-send-email-sr@denx.de>
Content-Type: text/plain
Date: Fri, 18 Jan 2008 07:53:52 +1100
Message-Id: <1200603232.7222.0.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2008-01-16 at 10:37 +0100, Stefan Roese wrote:
> With the removal the the "rgmii-interface" device_type property from the
> dts files, the newemac driver needs an update to only rely on compatible
> property.
> 
> Signed-off-by: Stefan Roese <sr@denx.de>
> ---

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Jeff, please stick that into your queue for 2.6.25, thanks !

Ben.

>  drivers/net/ibm_newemac/rgmii.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/net/ibm_newemac/rgmii.c b/drivers/net/ibm_newemac/rgmii.c
> index 9bc1132..5757788 100644
> --- a/drivers/net/ibm_newemac/rgmii.c
> +++ b/drivers/net/ibm_newemac/rgmii.c
> @@ -302,7 +302,6 @@ static int __devexit rgmii_remove(struct of_device *ofdev)
>  static struct of_device_id rgmii_match[] =
>  {
>  	{
> -		.type		= "rgmii-interface",
>  		.compatible	= "ibm,rgmii",
>  	},
>  	{
