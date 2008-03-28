Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 48028DE4F5
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Mar 2008 06:15:43 +1100 (EST)
Message-ID: <47ED43E1.3010104@freescale.com>
Date: Fri, 28 Mar 2008 14:15:45 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH] mtd/nand/fsl_elbc_nand: workaround for hangs during nand
	write [was: Re: [PATCH] mtd/nand/fsl_elbc_nand: workaround for hangs
	on MPC837X]
References: <20080328184303.GA25882@localhost.localdomain>
	<47ED3EC5.8030508@freescale.com>
	<20080328191054.GA30765@localhost.localdomain>
In-Reply-To: <20080328191054.GA30765@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
> From: Anton Vorontsov <avorontsov@ru.mvista.com>
> Subject: mtd/nand/fsl_elbc_nand: workaround for hangs during nand write
> 
> Using current driver elbc sometimes hangs during nand write. Reading back
> last byte helps though (thanks to Scott Wood for the idea).
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Acked-by: Scott Wood <scottwood@freescale.com>

-Scott
