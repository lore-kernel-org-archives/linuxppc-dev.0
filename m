Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 726A4DE034
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 07:31:17 +1000 (EST)
Message-ID: <49EF8C92.8050403@freescale.com>
Date: Wed, 22 Apr 2009 16:30:58 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] fs_enet: Remove dead code
References: <1240435170-5183-1-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1240435170-5183-1-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: netdev@vger.kernel.org, David Miller <davem@davemloft.net>,
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
> @@ -318,32 +314,6 @@ static void restart(struct net_device *dev)
>  	/*
>  	 * adjust to speed (only for DUET & RMII)
>  	 */
> -#ifdef CONFIG_DUET
> -	if (fpi->use_rmii) {

Please remove the comment that goes with the code being removed.

Otherwise, ACK.

-Scott
