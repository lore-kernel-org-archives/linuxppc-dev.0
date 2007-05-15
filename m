Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net
	[151.189.21.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5FAB4DDDD5
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 17:03:31 +1000 (EST)
In-Reply-To: <200705150846.09220.sr@denx.de>
References: <20070515020026.GG565@localhost.localdomain>
	<200705150811.09927.sr@denx.de>
	<20070515061855.GD6998@localhost.localdomain>
	<200705150846.09220.sr@denx.de>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <a057a8d0abc2ea1435e68666c80cf734@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Small fixes for the Ebony device tree
Date: Tue, 15 May 2007 09:02:48 +0200
To: Stefan Roese <sr@denx.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Why "ibm,xxx"? Is this for the CPU core? Or for the SDRAM controller 
> core?

For whatever is behind the comma.  The prefixes are
meant to give each manufacturer his own namespace,
to reduce the number of name collisions.

> Both are not IBM in this case.

Yeah.

> I forgot the new 405EX which will be equipped with a DDR2 controller 
> (not sure
> right now if it's the Denali or the other core right now). So we should
> probably drop this 40x/44x completely. Does this make sense?

Yes.  To claim compatibility to a family of devices,
specify the oldest part, or the most popular part,
or a few parts if different generations added more
features (and this part is compatible with those).


Segher
