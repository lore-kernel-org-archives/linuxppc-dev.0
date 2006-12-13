Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8E78867C50
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 01:46:21 +1100 (EST)
In-Reply-To: <1166001747.30422.43.camel@gentoo-jocke.transmode.se>
References: <1166001747.30422.43.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5CD24382-201C-4B60-B410-3746A032415A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Adapt spi_mpc83xx SPI driver for 832x
Date: Wed, 13 Dec 2006 08:46:16 -0600
To: joakim.tjernlund@transmode.se
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 13, 2006, at 3:22 AM, Joakim Tjernlund wrote:

> The MPC 832x has a different SPI controller i/f, probably due to
> its QUICC engine support. This patch adapts the spi_mpx83xx driver to
> be usable on QE based 83xx cpus.
>
>  Jocke

One problem I have with this patch is the fact that it assumes the  
current driver for (mpc834x) and your mods to support mpc832x/QE are  
mutually exclusive.

We need to handle the case of having driver support for both the QE  
and MPC834x style in the same kernel.

- k

>
> PS.
>    Sorry for the attatcment, I have yet to figure out how to tell
>    evolution not to mangle inline patches.
> <spi2.diff>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
