Return-Path: <rubini@mail.gnudd.com>
Received: from mail.gnudd.com (adsl-203-134.38-151.net24.it [151.38.134.203])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 05E896895A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Dec 2005 02:07:53 +1100 (EST)
Date: Wed, 28 Dec 2005 16:07:42 +0100
From: Alessandro Rubini <rubini@gnudd.com>
To: avolkov@varma-el.com
Message-ID: <20051228150742.GA18401@mail.gnudd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: rubini@ar.linux.it
In-Reply-To: <43B2A902.3090008@varma-el.com>
References: <43B2A902.3090008@varma-el.com>
	<200512271730.28563.david.jander@protonic.nl>
	<20051227214949.GA8236@mail.gnudd.com>
	<200512281000.12073.david.jander@protonic.nl>
Cc: r.schwebel@pengutronix.de, david.jander@protonic.nl,
	socket-can@pengutronix.de, linuxppc-embedded@ozlabs.org
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


> Robert Schwebel et al have worked socket based CAN (i.e. implement CAN
> as _net_ dev, not as char)

That's great. I've always been convinced it is the right way to go.
I remember I've said so to a friend in March 2002.  Unfortunately,
I had no time to do it the right way, due to short deadlines and
tight budget.  I'm happy Robert did it.

/alessandro
