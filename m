Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1DCECDDD0A
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 23:59:06 +1000 (EST)
In-Reply-To: <Pine.LNX.4.64.0709131554530.29675@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0709131554530.29675@blarg.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <AC7B9A70-5050-4191-A20E-B92686B675D4@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Please pull from for-2.6.24
Date: Fri, 14 Sep 2007 09:02:04 -0500
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 13, 2007, at 3:55 PM, Kumar Gala wrote:

> Please pull from 'for-2.6.24' branch of
>
> 	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git  
> for-2.6.24
>
> to receive the following updates:

I've updated the branch with the following changes:

> Anton Vorontsov (3):
>       [POWERPC] MPC832x_RDB: Update dts to use SPI1 in QE, register  
> mmc_spi stub

Updated commit message.  (let me know if you want me to drop this for  
now and wait til mmc_spi gets merged)

> Roy Zang (1):
>       [POWERPC] Update mpc7448hpc2 device tree to be compatible for  
> tsi109 chip

Dropped for now.  I doubt we want this based on Segher's comments.   
(pretty sure its a ts108 on the hpc2 board).

- k
