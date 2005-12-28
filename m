Return-Path: <rubini@mail.gnudd.com>
Received: from mail.gnudd.com (adsl-203-134.38-151.net24.it [151.38.134.203])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 358616895A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Dec 2005 00:19:46 +1100 (EST)
Date: Wed, 28 Dec 2005 14:19:39 +0100
From: Alessandro Rubini <rubini@gnudd.com>
To: david.jander@protonic.nl
Message-ID: <20051228131939.GA17170@mail.gnudd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: rubini@ar.linux.it
In-Reply-To: <200512281000.12073.david.jander@protonic.nl>
References: <200512281000.12073.david.jander@protonic.nl>
	<200512271730.28563.david.jander@protonic.nl>
	<20051227214949.GA8236@mail.gnudd.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Which CAN driver to port to for PPC
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hello.

> The problem I see with Ocan is that it has a very different API than all the 
> others.

I know. When I started the project there only was one driver, and
it was already very complex. But it lacked the select method(now
poll), and had other serious design problems. So I started mine,
without advertising it.

Now I have a few happy users, and they want to keep my API in their
applications, so I'm stuck with it.

> I wonder how the port to SJA1000 will turn out, since I believe it
> would have to emulate some 82527-specific stuff, in order to offer a
> compatible API.

True, but the chip isn't _that_ different, actually.

> I am convinced though, that there should be a chip/card-independent
> API to the application-programmer, and that effort should be done to
> converge into the same direction.

Yes, that is how things should be, in an ideal world.

> So, wouldn't it be better to try to unite forces and at least offer
> similar API's, or even better, develop a standard linux CAN
> framework?

It would. Anyone willing to lead this effort? [no offence or humor
intended, I am interested in following it, but can't lead it myself]

Thanks for your comments
/alessandro
