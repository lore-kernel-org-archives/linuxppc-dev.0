Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id BB862DEFD2
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 06:00:20 +1000 (EST)
Date: Wed, 21 May 2008 22:00:18 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/4] [OF] spi_of: add support for dedicated SPI
	constructors
In-Reply-To: <fa686aa40805211253l173cd68v77f40cf70ff6b949@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0805212157580.5386@axis700.grange>
References: <20080521154103.GA32577@polina.dev.rtsoft.ru>
	<20080521154139.GB4566@polina.dev.rtsoft.ru>
	<Pine.LNX.4.64.0805211754300.5386@axis700.grange>
	<20080521161039.GA9050@polina.dev.rtsoft.ru>
	<Pine.LNX.4.64.0805211820460.5386@axis700.grange>
	<20080521164841.GA17813@polina.dev.rtsoft.ru>
	<fa686aa40805211005h58ea66dfl792eae460d4ea3d@mail.gmail.com>
	<Pine.LNX.4.64.0805211940060.5386@axis700.grange>
	<fa686aa40805211206g5f23d3dax3e33c5aebe7aa4f1@mail.gmail.com>
	<Pine.LNX.4.64.0805212115310.5386@axis700.grange>
	<fa686aa40805211253l173cd68v77f40cf70ff6b949@mail.gmail.com>
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

On Wed, 21 May 2008, Grant Likely wrote:

> On Wed, May 21, 2008 at 1:20 PM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> >
> > Right again - _rare_ corner cases. Whereas we are talking about _all_ SPI
> > busses, maybe apart from those, where the controller itself switches CSs
> > in a well-defined way, and the driver doesn't need any additional
> > information to handle this.
> 
> Ah, I see where we are crossing our wires.  I was talking about the
> case of registering spi devices.  I agree that the spi bus should not
> need any additional information.

No, sorry for not making it clear. I wrote "busses" because on those 
controllers, that control CS themselves _devices_ don't need any 
additional info. But I meant, that describing SPI _devices_ should be done 
in only one way or another - either using fdt, or platform data, not both.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
