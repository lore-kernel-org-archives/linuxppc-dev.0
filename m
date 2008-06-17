Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C436DDE11B
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 05:33:35 +1000 (EST)
Message-ID: <48581188.90102@freescale.com>
Date: Tue, 17 Jun 2008 14:33:28 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: John Rigby <jrigby@freescale.com>
Subject: Re: [PATCH] [Rev2] MPC5121 FEC support
References: <1213729717-26688-1-git-send-email-jrigby@freescale.com>
In-Reply-To: <1213729717-26688-1-git-send-email-jrigby@freescale.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, jeff@garzik.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

John Rigby wrote:
>  config FS_ENET
>         tristate "Freescale Ethernet Driver"
> -       depends on CPM1 || CPM2
> +       depends on CPM1 || CPM2 || FS_ENET_MPC5121_FEC
>         select MII
>         select PHYLIB
>  
> +config FS_ENET_MPC5121_FEC
> +	bool "Freescale MPC512x FEC driver"
> +	depends on PPC_MPC512x
> +	select FS_ENET
> +	select PPC_CPM_NEW_BINDING
> +	default y

No default y.

-Scott
