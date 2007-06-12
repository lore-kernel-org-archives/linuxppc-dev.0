Return-Path: <dgibson@ozlabs.org>
Date: Tue, 12 Jun 2007 13:45:22 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: xu chen <chenxurcy@yahoo.com.cn>
Subject: Re: opb_ethernet driver
Message-ID: <20070612034522.GA4198@localhost.localdomain>
References: <22250.22723.qm@web92006.mail.cnb.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <22250.22723.qm@web92006.mail.cnb.yahoo.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jun 11, 2007 at 10:37:55AM +0800, xu chen wrote:
> Hello.
>       I'm porting an opb_ethernet driver to my ml403 board now, using the 2.6.17 kernel. I know the ethernet support 3 mode: No DMA, simple DMA, scatter gather DMA, when I use the No DMA mode, we can write the skb into the FIFO, but can't ping other PCs in the network. When I use the simple DMA mode, at the time of ping, in the driver, we should initialize the DMA channel, but when transfering the skb, the DMA returns a "DMA bus time out" signal. 
>      Now I'm worry about it. Who had encountered the problem before? I think I need some help.

What's an opb_ethernet?

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
