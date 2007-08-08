Return-Path: <willis@arlut.utexas.edu>
Received: from ns2.arlut.utexas.edu (ns2.arlut.utexas.edu [146.6.211.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 713B4DDE32
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Aug 2007 08:18:31 +1000 (EST)
Subject: Re: Fedora 7 on a non FPU system
From: Michael Brian Willis <willis@arlut.utexas.edu>
To: Clemens Koller <clemens.koller@anagramm.de>
In-Reply-To: <46B8E76F.3020403@anagramm.de>
References: <20070313043050.GB82243@server.idefix.lan>
	<513703.69187.qm@web302.biz.mail.mud.yahoo.com>
	<20070314043305.GB27011@server.idefix.lan>
	<20070314065411.GD14658@moe.telargo.com>
	<1186508561.5592.26.camel@louie> <46B8E76F.3020403@anagramm.de>
Content-Type: text/plain
Date: Wed, 08 Aug 2007 17:18:22 -0500
Message-Id: <1186611502.12665.26.camel@louie>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 2007-08-07 at 23:43 +0200, Clemens Koller wrote:

> You can either use FPU emulation or do the floating point stuff on the e500
> core's SPE (Signal Processing Engine) which is AFAIK not supported by any
> major distribution.

I do have FPU emulation enabled in the kernel. I was able to get a
Yellow Dog 4.1 root filesystem to work. However when I move up to
YellowDog 5.0 or to Fedora 7, I have system lags. (For example, shortly
after boot-up, date and top do not behave properly. For example top
displays "nan" values. However a few minutes after boot up everything
seems fine.)

I suspect that the newest distribution versions rely more heavily on
full FPU functionality while the older distributions don't. Which might
be why older distributions seem to work a little better. 



> CRUX - not a "major distro", because it's targeted at "experienced Linux users".
> I am running my selfmade version of "embedded CRUX" on my MPC8540 Boards
> based on http://cruxppc.sunsite.dk/wp/index.php which now fully supports
> the e500 core features.

Thanks, I will start looking into using CRUX. 



> I bootstrapped the toolchain (binutils, (e)glibc, gcc and friends) from scratch

Did you find any documentation that was helpful when you did this? 
I'm not really sure how to start this process. Do you basically just
download binutils, glibc etc... and compile them using the gcc that
comes with CRUX? 



Thanks again for all your help!

Regards, 

Michael Willis
Applied Research Labs-University of Texas
willis@arlut.utexas.edu
