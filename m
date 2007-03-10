Return-Path: <domen.puncer@telargo.com>
Received: from kukmak.uni-mb.si (kukmak.uni-mb.si [164.8.100.3])
	by ozlabs.org (Postfix) with ESMTP id E2514DDDFA
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 11 Mar 2007 01:50:21 +1100 (EST)
Date: Sat, 10 Mar 2007 15:50:13 +0100
From: Domen Puncer <domen.puncer@telargo.com>
To: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: [PATCH] lite5200(b) dts: mscan.1 irq
Message-ID: <20070310145013.GA22875@nd47.coderock.org>
References: <20070306095139.GZ4397@moe.telargo.com>
	<20070309084954.GA14658@moe.telargo.com>
	<20070310115347.GD4067@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070310115347.GD4067@pengutronix.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 10/03/07 12:53 +0100, Robert Schwebel wrote:
> Domen,
> 
> On Fri, Mar 09, 2007 at 09:49:54AM +0100, Domen Puncer wrote:
> > Btw. I forward ported Freescale's mscan patch to latest
> > peak-linux-driver. Should I send it somewhere? Where to?
> 
> Is that for the "old" peak driver, or for the new SocketCAN based ones? 
> Note that Peak is moving to SocketCAN recently - see
> 
> http://developer.berlios.de/projects/socketcan/

Hah, I didn't expect a new release just a day or two after I
downloaded the source. :-P
I did it against 5.12; 6.0 and SocketCAN are definitely worth
checking out.

Thanks!


	Domen

> 
> Robert
> -- 
>  Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
>  Pengutronix - Linux Solutions for Science and Industry
>    Handelsregister:  Amtsgericht Hildesheim, HRA 2686
>      Hannoversche Str. 2, 31134 Hildesheim, Germany
>    Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
