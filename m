Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 9130ADDE20
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 03:50:43 +1000 (EST)
Date: Wed, 21 May 2008 19:51:00 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/4] [OF] spi_of: add support for dedicated SPI
	constructors
In-Reply-To: <fa686aa40805211005h58ea66dfl792eae460d4ea3d@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0805211940060.5386@axis700.grange>
References: <20080521154103.GA32577@polina.dev.rtsoft.ru>
	<20080521154139.GB4566@polina.dev.rtsoft.ru>
	<Pine.LNX.4.64.0805211754300.5386@axis700.grange>
	<20080521161039.GA9050@polina.dev.rtsoft.ru>
	<Pine.LNX.4.64.0805211820460.5386@axis700.grange>
	<20080521164841.GA17813@polina.dev.rtsoft.ru>
	<fa686aa40805211005h58ea66dfl792eae460d4ea3d@mail.gmail.com>
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

> I concede that sometimes platform code just has to pass data to the
> driver that cannot be described in the device tree.  callback pointers
> being the most significant example and we do need a sane way to do so.

Sorry, I just cannot understand. So far my understanding was, that OF 
bindings were there to _completely_ describe hardware, that cannot be 
autoconfigured or probed. So a _generic_ driver gets all information it 
needs from the device tree and needs no additional information to handle 
the hardware.

Now if a driver needs additional information from "platform code" what's 
the purpose of partial data in the device tree at all? Just use board 
information as usual.

What good is an OF-binding if it doesn't provide complete information?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
