Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao02.cox.net (fed1rmmtao02.cox.net [68.230.241.37])
	by ozlabs.org (Postfix) with ESMTP id DF23E6829E
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Sep 2005 00:08:56 +1000 (EST)
Date: Mon, 19 Sep 2005 07:08:44 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
Message-ID: <20050919070844.B25356@cox.net>
References: <ea43f4f9050825183121655ba2@mail.gmail.com>
	<431260BA.7000107@jonmasters.org>
	<20050830083859.B5925@cox.net> <200509151803.15301.sr@denx.de>
	<20050915092555.A27452@cox.net>
	<732f7227a8bcc2f3115e52633a60f120@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <732f7227a8bcc2f3115e52633a60f120@embeddededge.com>;
	from dan@embeddededge.com on Thu, Sep 15, 2005 at 03:03:23PM -0400
Cc: Stefan Roese <sr@denx.de>, linuxppc-embedded@ozlabs.org
Subject: Re: PPC4xx cleanup
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Sep 15, 2005 at 03:03:23PM -0400, Dan Malek wrote:
> 
> On Sep 15, 2005, at 12:25 PM, Matt Porter wrote:
> 
> > Sounds great to me. This will have to wait to go in mainline until
> > after 2.6.14 is out though.
> 
> If you are considering this, I think you should be looking at the
> recent U-Boot discussion and patches for the "flat OF tree" and
> follow that path.

We need to fix the kernel versus the current version of U-boot's data
passing scheme for ppc32. Once the flat OF tree stuff is mainline we
can convert to it...except we have to have a wrapper for older versions
of u-boot assuming that somebody will have changed U-boot so 4xx dumps
a flat OF tree.

-Matt
