Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (unknown [65.200.49.142])
	by ozlabs.org (Postfix) with SMTP id C53D26828C
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Sep 2005 09:45:00 +1000 (EST)
Date: 15 Sep 2005 23:44:57 -0000
Message-ID: <20050915234457.6761.qmail@xyzzy.farnsworth.org>
From: "Dale Farnsworth" <dale@farnsworth.org>
To: det.nicolas@free.fr
In-Reply-To: <20050914091229.A27721C007F7@mwinf0309.wanadoo.fr>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: SRAM support for the Pegasos II platform
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In article <20050914091229.A27721C007F7@mwinf0309.wanadoo.fr> you write:
> You can find enclosed or at the URL a patch for the 2.6.14-rc1.
> http://arrakin.homedns.org/~nicolas/mv643xx_eth_chrp_pegasos_eth.c.2.6.14-rc1.diff
> 
> It allows (with drivers/net/mv643xx_eth.*) to take advantage of the SRAM of
> the Marvell Discovery II for the network driver.
> 
> Reviews and comments welcome.

Hi Nicolas,

+#define PEGASOS2_SRAM_SIZE				(0x00008000)

I think the SRAM is 256KB, so shouldn't this be 0x00040000 ?

-Dale
