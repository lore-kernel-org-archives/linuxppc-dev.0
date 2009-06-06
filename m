Return-Path: <jacmet@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 28064B7090
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  7 Jun 2009 01:22:00 +1000 (EST)
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.155])
	by ozlabs.org (Postfix) with ESMTP id 47C56DDD1B
	for <linuxppc-dev@ozlabs.org>; Sun,  7 Jun 2009 01:21:58 +1000 (EST)
Received: by fg-out-1718.google.com with SMTP id e21so834780fga.16
	for <linuxppc-dev@ozlabs.org>; Sat, 06 Jun 2009 08:21:56 -0700 (PDT)
Sender: Peter Korsgaard <jacmet@gmail.com>
To: Joachim Foerster <JOFT@gmx.de>
Subject: Re: SD card over (xilinx_)SPI, timeout error while CID
References: <1244216069.21470.12.camel@localhost>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Sat, 06 Jun 2009 17:14:24 +0200
In-Reply-To: <1244216069.21470.12.camel@localhost> (Joachim Foerster's message
	of "Fri\, 05 Jun 2009 17\:34\:29 +0200")
Message-ID: <87bpp1xulr.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: joachim@missinglinkelectronics.com, linuxppc-dev@ozlabs.org,
	dbrownell@users.sourceforge.net, john.linn@xilinx.com,
	lorenz@missinglinkelectronics.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>>>> "Joachim" == Joachim Foerster <JOFT@gmx.de> writes:

Hi,

 Joachim> Any hints? Does anybody use SD card support with
 Joachim> mmc_spi+xilinx_spi ?

I don't, but have you compared the spi signals on a scope in the 2
setups? Is timing significantly different?

-- 
Bye, Peter Korsgaard
