Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao03.cox.net (fed1rmmtao03.cox.net [68.230.241.36])
	by ozlabs.org (Postfix) with ESMTP id C2ABD2BF0B
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  5 Nov 2004 01:28:33 +1100 (EST)
Date: Thu, 4 Nov 2004 07:28:28 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Vladimir <vova-ks@yandex.ru>
Message-ID: <20041104072828.A11524@home.com>
References: <200411031241.40681.vova-ks@yandex.ru>
	<200411031717.55398.vova-ks@yandex.ru>
	<20041103073630.A3485@home.com>
	<200411040134.23806.vova-ks@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200411040134.23806.vova-ks@yandex.ru>;
	from vova-ks@yandex.ru on Thu, Nov 04, 2004 at 01:34:23AM +0300
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: kgdb on 405GP walnut-like board.
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Nov 04, 2004 at 01:34:23AM +0300, Vladimir wrote:
> On Wednesday 03 November 2004 17:36, Matt Porter wrote:
> > The patch is against the current 2.6 BK tree, try patching a recent kernel
> > release like 2.6.10-rc1.
> I've tried 2.6.10-rc1-bk13 from kernel.org. Is it already include this patch ?
> It successfully compiles, but at breakpoint() it fails to connect to host's 
> gdb. I've grab /dev/ttyS1 traffic and see that kgdb stub sends to host a lot 
> of zeros - nothing more. May be this is bug in serial port initialization ? 
> How can I deal with it ?

Check what your firmware sets the default baud rate to on the second
UART. I had to set remotebaud 57600 on walnut, IIRC...I'm a little
hazy since that's not my primary devel platform. I think you are
on a different board anyway.

-Matt
