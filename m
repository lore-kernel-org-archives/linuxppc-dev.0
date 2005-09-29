Return-Path: <dan@embeddedalley.com>
Received: from smtp102.biz.mail.re2.yahoo.com (smtp102.biz.mail.re2.yahoo.com
	[68.142.229.216]) by ozlabs.org (Postfix) with SMTP id 8D200683BC
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 Sep 2005 00:14:54 +1000 (EST)
In-Reply-To: <8D4C69676E66D511A1CB00508BBBB192052D42EF@ranmx1.cs.myharris.net>
References: <8D4C69676E66D511A1CB00508BBBB192052D42EF@ranmx1.cs.myharris.net>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <e72174fb80ef1a6d7da33ae7a0e8ea02@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Date: Thu, 29 Sep 2005 10:03:31 -0400
To: "Fend, Matthias" <mfend@harris.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: mpc8xx and LCD
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Sep 29, 2005, at 2:53 AM, Fend, Matthias wrote:

> At the moment I think we should use a lcd controller from Epson 
> (S1D13700 or S1D13305) since they are
> working on Linux framebuffer device driver for it.

Well, check carefully.  As I recall, those parts have been
discontinued.  Although there is software, you may not be able to
build products once it is done.  I'd suggest looking first at
Fujitsu, and second at Silicon Motion.  Both of these companies
have claimed to be dedicated to providing the embedded
parts for a long time.

> Has anybody else implemented a LCD into a mpc8xx (not 823) board 
> successfully ?

Of course.  It has an internal LCD/video controller, and there should be
drivers in various kernels.

Thanks.

	-- Dan
