Return-Path: <garyj@denx.de>
Received: from mout5.freenet.de (mout5.freenet.de [195.4.92.95])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5EC80DDF39
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 22:26:46 +1000 (EST)
Date: Tue, 20 May 2008 14:26:38 +0200
From: Gary Jennejohn <garyj@denx.de>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 3/4] spi: Add OF binding support for SPI busses
Message-ID: <20080520142638.2efcaf97@peedub.jennejohn.org>
In-Reply-To: <20080519171949.GA12616@polina.dev.rtsoft.ru>
References: <20080516193054.28030.35126.stgit@trillian.secretlab.ca>
	<20080516193613.28030.13950.stgit@trillian.secretlab.ca>
	<Pine.LNX.4.64.0805191446530.27140@axis700.grange>
	<fa686aa40805190857u317d3304ie75d11870e109fc5@mail.gmail.com>
	<20080519190900.01ec3b2a@peedub.jennejohn.org>
	<20080519171949.GA12616@polina.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
Reply-To: gary.jennejohn@freenet.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 19 May 2008 21:19:50 +0400
Anton Vorontsov <avorontsov@ru.mvista.com> wrote:

> On Mon, May 19, 2008 at 07:09:00PM +0200, Gary Jennejohn wrote:
[snip extraneous content]
> > My problem was, and is, that there's no generic GPIO support for powerpc.
> > At least, not that I'm aware of.  Please tell me if I'm wrong.
> 
> Documentation/powerpc/booting-without-of.txt
> VIII - Specifying GPIO information for devices.
> 
> And include/linux/of_gpio.h + drivers/of/gpio.c.
> 

Thanks! I'll look into using this.

---
Gary Jennejohn
*********************************************************************
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
*********************************************************************
