Return-Path: <sr@denx.de>
Received: from natblert.rzone.de (natblert.rzone.de [81.169.145.181])
	by ozlabs.org (Postfix) with ESMTP id 6C83767B5F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Sep 2006 05:26:50 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Uncompressing Kernel Image ... Error: inflate() returned -3
	GUNZIP ERROR - must RESET board to recover
Date: Thu, 28 Sep 2006 21:28:05 +0200
References: <HOECLKEKOHLAMMGDLLBHGEKJHLAA.stelios@stelioscellar.com>
	<137d01c6e288$844fcdd0$8119fea9@deltatau.local>
In-Reply-To: <137d01c6e288$844fcdd0$8119fea9@deltatau.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200609282128.06350.sr@denx.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Henry,

On Thursday 28 September 2006 00:58, Henry Bausley wrote:
> Uncompressing Kernel Image ... Error: inflate() returned -3
> GUNZIP ERROR - must RESET board to recover
> OK
>
> when u-boot tries to uncompress the kernel.  I am using a board based upon
> a Yosemite AMCC 440EP.
> I do have some boards that work.  Does anyone know what could cause this
> problem.  Bad Flash , Bad DDR ?

I would suspect a DDR problem. Please (re-)check your DDR setup and 
configuration.

BTW: This is the wrong mailinglist. You should post to the U-Boot list 
instead.

Best regards,
Stefan
