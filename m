Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id E3D74DE054
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 05:20:30 +1000 (EST)
Date: Wed, 21 May 2008 21:20:27 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/4] [OF] spi_of: add support for dedicated SPI
	constructors
In-Reply-To: <fa686aa40805211206g5f23d3dax3e33c5aebe7aa4f1@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0805212115310.5386@axis700.grange>
References: <20080521154103.GA32577@polina.dev.rtsoft.ru>
	<20080521154139.GB4566@polina.dev.rtsoft.ru>
	<Pine.LNX.4.64.0805211754300.5386@axis700.grange>
	<20080521161039.GA9050@polina.dev.rtsoft.ru>
	<Pine.LNX.4.64.0805211820460.5386@axis700.grange>
	<20080521164841.GA17813@polina.dev.rtsoft.ru>
	<fa686aa40805211005h58ea66dfl792eae460d4ea3d@mail.gmail.com>
	<Pine.LNX.4.64.0805211940060.5386@axis700.grange>
	<fa686aa40805211206g5f23d3dax3e33c5aebe7aa4f1@mail.gmail.com>
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

> If some behaviour is entirely board specific and doesn't have any
> possibility of being duplicated on other boards, then it makes sense
> for the code implementing that behaviour to live with the platform
> code.

Exactly - "entirely board specific" and "doesn't have any possibility of 
being duplicated on other boards."

> > What good is an OF-binding if it doesn't provide complete information?
> 
> It still increases the amount of common code even if there are rare
> corner cases that require board specific code.

Right again - _rare_ corner cases. Whereas we are talking about _all_ SPI 
busses, maybe apart from those, where the controller itself switches CSs 
in a well-defined way, and the driver doesn't need any additional 
information to handle this.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
