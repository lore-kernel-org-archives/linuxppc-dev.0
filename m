Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 10ED8DDDF0
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Feb 2007 18:03:28 +1100 (EST)
In-Reply-To: <Pine.LNX.4.61.0702081718400.507@ld0175-tx32.am.freescale.net>
References: <Pine.LNX.4.61.0702081718400.507@ld0175-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <36A86ACB-F181-4579-B6FE-99455BF1E1DC@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/2] Added support for the MPC8568E MDS board
Date: Fri, 9 Feb 2007 01:02:37 -0600
To: Andy Fleming <afleming@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> +/ {
> +	model = "MPC8568EMDS";
> +	compatible = "MPC85xx";
>

MPC85xxMDS instead, its implicit that its a MPC85xx.

- k
