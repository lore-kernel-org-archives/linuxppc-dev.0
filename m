Return-Path: <dale@farnsworth.org>
Received: from farnsworth.org (unknown [65.200.49.142])
	by ozlabs.org (Postfix) with SMTP id 3C214681B8
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jan 2006 06:09:03 +1100 (EST)
Date: 12 Jan 2006 19:09:00 -0000
Message-ID: <20060112190900.23594.qmail@farnsworth.org>
From: "Dale Farnsworth" <dale@farnsworth.org>
To: pegasos@frokaschwei.de, linuxppc-dev@ozlabs.org
In-Reply-To: <200601121329.11693@mail.frokaschwei.de>
Subject: Re: mv643xx_eth.c: Multicast and IPv6 support
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In article <200601121329.11693@mail.frokaschwei.de>
pegasos@frokaschwei.de writes:
> currently, the driver mv643xx_eth.c doesn't support receiving of multicast and 
> sending of IPv6 packets.
> I found a piece of code in the u-boot bootloader which supports multicast 
> receiving and did some cut and paste. Now receiving multicast packets works 
> for me.
> To be able to send IPv6 packets I had to remove the NETIF_F_HW_CSUM flag. 
> Hardware checksumming for IPv4 should continue to work because of the 
> NETIF_F_IP_CSUM flag.
> 
> I attach a diff against 2.6.15.

Thanks.  On December 28th, I posted a patch to netdev@vger.kernel.org that
adds multicast support to the mv643xx driver.  I'll ping jgarzik
about it.

The IPv6 changes look good.  Would you please re-submit these without
the multicast changes and with a Signed-off-by line?

-Dale
