Return-Path: <wd@denx.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id AB478B7199
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Jun 2009 07:07:58 +1000 (EST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id EEF51DDD0B
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 07:07:56 +1000 (EST)
To: Ricardo Ribalda Delgado <ricardo.ribalda@uam.es>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: SD card over (xilinx_)SPI, timeout error while CID
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <aa76a2be0906111349s2ff947eo35149ef14e29d05a@mail.gmail.com>
References: <1244216069.21470.12.camel@localhost>
	<aa76a2be0906111215j15933053rf128f1985a982ca0__26561.0047536486$1244748319$gmane$org@mail.gmail.com>
	<4A316386.4020404@missinglinkelectronics.com>
	<aa76a2be0906111349s2ff947eo35149ef14e29d05a@mail.gmail.com>
Date: Thu, 11 Jun 2009 23:07:51 +0200
Message-Id: <20090611210751.A7130832E416@gemini.denx.de>
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

Dear Ricardo Ribalda Delgado,

In message <aa76a2be0906111349s2ff947eo35149ef14e29d05a@mail.gmail.com> you wrote:
> 
> > What frequency does Your SPI-Bus use?
> 
> 33Mhz.... arghh. just checked is over the standard...  Tomorrow I will
> test with a slower clk

Just some really stupid questions:

This is with a 4xx core, right? Is this the same SPI controller design
like in AMCC's 40x and 44x cores, i. e. with a "FIFO" of depth 1?

Assuming you're running your SPI clock at 1 MHz,  you  get  one  data
byte  and  thus  one interrupt at a rate of 125 kHz. I doubt your CPU
can handle such a load?


Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
A witty saying proves nothing, but saying  something  pointless  gets
people's attention.
