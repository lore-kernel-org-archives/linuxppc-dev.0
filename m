Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 8A048DE287
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 02:24:42 +1000 (EST)
Date: Wed, 21 May 2008 18:24:58 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 2/4] [OF] spi_of: add support for dedicated SPI
	constructors
In-Reply-To: <20080521161039.GA9050@polina.dev.rtsoft.ru>
Message-ID: <Pine.LNX.4.64.0805211820460.5386@axis700.grange>
References: <20080521154103.GA32577@polina.dev.rtsoft.ru>
	<20080521154139.GB4566@polina.dev.rtsoft.ru>
	<Pine.LNX.4.64.0805211754300.5386@axis700.grange>
	<20080521161039.GA9050@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Gary Jennejohn <garyj@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 21 May 2008, Anton Vorontsov wrote:

> On Wed, May 21, 2008 at 05:56:33PM +0200, Guennadi Liakhovetski wrote:
> > 
> > Hm, I might well misunderstand something here, but it looks to me like you 
> > are again trying to use both OF _and_ platform (spi_board_info) bindings 
> > for your SPI setup?
> 
> Yes, you didn't misunderstand. ;-)
> 
> > And this is exactly what we are trying to avoid in 
> > Grant's series of patches...
> 
> I didn't find other way... The show stopper is "master" argument,
> drivers don't know about masters (and should not, since if they should,
> then this implies that masters should be registered prior to devices,
> and that complicates everything).
> 
> What is the problem with board infos, btw? I missed that part. Board

In short: board infos are not bad as such. I find it bad if you have to 
use both OF and platform bindings to describe _one_ piece of hardware. For 
more details you might want to re-read the thread, so, we don't have to 
discuss the same issues again.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
