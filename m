Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0FA37DE289
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 12:16:29 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m2Q1GNxJ026785
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Mar 2008 18:16:23 -0700 (MST)
Date: Tue, 25 Mar 2008 20:16:20 -0500
From: Scott Wood <scottwood@freescale.com>
To: Jon Loeliger <jdl@freescale.com>, linuxppc-dev@ozlabs.org
Subject: Re: dtc: Simplify error handling for unparseable input
Message-ID: <20080326011620.GA2927@ld0162-tx32.am.freescale.net>
References: <20080324034424.GC29985@localhost.localdomain>
	<20080324173641.GA22159@loki.buserror.net>
	<20080325012805.GA1227@localhost.localdomain>
	<20080325143619.GB13187@ld0162-tx32.am.freescale.net>
	<20080325212127.GA8281@localhost.localdomain>
	<47E9783F.4@freescale.com>
	<20080325235202.GG8281@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080325235202.GG8281@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 26, 2008 at 10:52:02AM +1100, David Gibson wrote:
> On Tue, Mar 25, 2008 at 05:10:07PM -0500, Scott Wood wrote:
> > It's generally nice to the user if you can report as many bugs as you can 
> > rather than fail on the first one.
> 
> Hrm, I guess.  There's only so far it's worth going to achieve that
> though.
> 
> > It's also nice to someone down the road trying to turn this code into a 
> > library if it passes return status up the call chain gracefully.
> 
> Can you think of any reason we'd want to do that? 

Anything that wants to do something automated with device tree source
that doesn't fit neatly into command-line execution.  Nothing specific.

> And that would require fixing so many other places that the two cases
> which do return an error (that's including binary includes) hardly
> signify.

Yeah, I just wanted to avoid going further down that path if possible.

I won't protest too loudly if the general consensus is to just die(),
though.

-Scott
