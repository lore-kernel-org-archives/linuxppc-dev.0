Return-Path: <ricardo.ribalda@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 9EA16B7124
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Jun 2009 07:17:19 +1000 (EST)
Received: from mail-ew0-f215.google.com (mail-ew0-f215.google.com
	[209.85.219.215]) by ozlabs.org (Postfix) with ESMTP id CCFF3DDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 07:17:18 +1000 (EST)
Received: by ewy11 with SMTP id 11so2259942ewy.9
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 14:17:16 -0700 (PDT)
MIME-Version: 1.0
Sender: ricardo.ribalda@gmail.com
In-Reply-To: <20090611210751.A7130832E416@gemini.denx.de>
References: <1244216069.21470.12.camel@localhost>
	<4A316386.4020404@missinglinkelectronics.com>
	<aa76a2be0906111349s2ff947eo35149ef14e29d05a@mail.gmail.com>
	<20090611210751.A7130832E416@gemini.denx.de>
From: Ricardo Ribalda Delgado <ricardo.ribalda@uam.es>
Date: Thu, 11 Jun 2009 23:16:56 +0200
Message-ID: <aa76a2be0906111416x24991b1i55bbc7238b4d021b@mail.gmail.com>
Subject: Re: SD card over (xilinx_)SPI, timeout error while CID
To: Wolfgang Denk <wd@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: jan.nikitenko@gmail.com, Lorenz Kolb <lorenz@missinglinkelectronics.com>,
	dbrownell@users.sourceforge.net, Joachim Foerster <JOFT@gmx.de>,
	hp@axis.com, linuxppc-dev@ozlabs.org, mike@steroidmicros.com,
	pierre@ossman.eu, joachim@missinglinkelectronics.com,
	john.linn@xilinx.com, linuxkernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Wolfgang

>
> This is with a 4xx core, right? Is this the same SPI controller design
> like in AMCC's 40x and 44x cores, i. e. with a "FIFO" of depth 1?

It is a ppc440 but it is does not have ans  spi controller as in the
amcc. The spi controller is a xilinx core allocated at the plb bus,
including a deeper fifo.

The actual version  does not have a sustained speed of 33Mhz but a can
have a peak speed of 33 MHz


               Thanks for your comment


-- 
Ricardo Ribalda
http://www.eps.uam.es/~rribalda/
