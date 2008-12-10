Return-Path: <jamuelle@ee.ethz.ch>
Received: from smtp.ee.ethz.ch (smtp.ee.ethz.ch [129.132.2.219])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D9170DDFC1
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 Dec 2008 10:13:58 +1100 (EST)
Date: Thu, 11 Dec 2008 00:13:48 +0100
From: Jan Mueller <jamuelle@ee.ethz.ch>
To: Joachim Meyer <Jogi95@web.de>
Subject: Re: XUPV2P update to kernel 2.6 fails
Message-ID: <20081210231347.GA8458@ee.ethz.ch>
References: <1149420832@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1149420832@web.de>
Cc: John Linn <John.Linn@xilinx.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

Thanks a lot for the answers!

Now I don't feel so alone anymore...

I finally got it to work. The problem was simple: I'm using an
uart pcore from openpcores. And this hardware requires some
changes to the ns16550 kernel driver... With those changes,
everything goes well! I'm happy about that.. ;-)

But... since everything seems to work now with EDK 9.1 I try to
use my XUP-board with the EDK 10.1

In EDK 10.1 there is no board definition file for my XUPV2P.
Right now I use the board file from:

  https://wiki.ittc.ku.edu/ittc/Eecs388#Tool_Repository

Now I got even stranger bahaviour than before. When ever I try
to boot into a linux kernel, some arbitrary boot parameters seem
to appear. Like:

	Loading from 0x00004000
	[...]

And after those messages the system hangs. (the real messages
vary from time to time)

I have to say that for the MemoryTestApp there seems to be no
problem.  It runs like a charm..

So now I'm wondering if anyone has a board definition file
usable for the linux kernel on the XUPV2P??

Thanks a lot for any hint!

Kind regards,
Jan

On Wed, Dec 10, 2008 at 11:05:13 +0100, Joachim Meyer wrote:
> Hi
> 
> I was setting up linux for teh XUP a few month ago. Both, older Kernels (with ppc and xparameters_ml300.h file) and new ones (with powerpc and device-tree) from the Xilinx git server worked fine for me, so yes, it should work.
> For more help you should say, what exactly you are doing, but maybe you have already found your error.
> Cheers,
> Joachim
> ____________________________________________________________________
> Psssst! Schon vom neuen WEB.DE MultiMessenger gehört? 
> Der kann`s mit allen: http://www.produkte.web.de/messenger/?did=3123
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
