Return-Path: <benjamin.heyne@uni-dortmund.de>
Received: from unimail.uni-dortmund.de (mx1.HRZ.Uni-Dortmund.DE
	[129.217.128.51]) by ozlabs.org (Postfix) with ESMTP id 464D667B57
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  7 Aug 2006 19:48:04 +1000 (EST)
Received: from bob.dt.e-technik.uni-dortmund.de
	(bob.dt.e-technik.Uni-Dortmund.DE [129.217.163.29])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.13.7/8.13.7) with ESMTP id k779kisM000777
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 7 Aug 2006 11:46:49 +0200 (CEST)
Date: Mon, 7 Aug 2006 11:46:43 +0200
From: Benjamin Heyne <benjamin.heyne@uni-dortmund.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: XUPV2P, Kernel 2.6.17 boot problem
Message-ID: <20060807114643.3c487a9b@bob.dt.e-technik.uni-dortmund.de>
In-Reply-To: <87lkq1uh7l.fsf@sleipner.barco.com>
References: <20060801100220.26176938@bob.dt.e-technik.uni-dortmund.de>
	<44D1021C.5080602@dlasys.net> <87irl8zjl7.fsf@sleipner.barco.com>
	<44D36940.7050908@dlasys.net> <87lkq1uh7l.fsf@sleipner.barco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

And so it came to pass, that on Mon, 07 Aug 2006 09:40:14 +0200
Peter Korsgaard <jacmet@sunsite.dk> wrote as thus:

> >>>>> "David" == David H Lynch <dhlii@dlasys.net> writes:
> 
> Hi,
> 
> David>     Have you tried 2.6.18.x to see if your stuff works with it
> David> ?
> 
> Yes, 2.6.18-rc3 + my zlib fix
> (http://thread.gmane.org/gmane.linux.kernel/428436) or -rc4 once it
> hits kernel.org works fine on my v2p-based board.

Well, unfortunately I am still getting the inflate error
as soon as the image grows >2MB (about). Have you tried with
images of this size? If the image is smaller, everything works
fine...

Best regards
Benjamin Heyne
