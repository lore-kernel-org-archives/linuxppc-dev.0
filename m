Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 0BB78DDD04
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Dec 2007 10:03:40 +1100 (EST)
Date: Mon, 24 Dec 2007 17:10:42 -0600
From: Olof Johansson <olof@lixom.net>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] Add information on enabling sound on the MPC8641 HPCN
Message-ID: <20071224231042.GA4588@lixom.net>
References: <11983809443854-git-send-email-timur@freescale.com>
	<20071223152613.GA4817@lixom.net> <476FEB43.8050507@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <476FEB43.8050507@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Dec 24, 2007 at 11:24:19AM -0600, Timur Tabi wrote:
> Olof Johansson wrote:
> 
> > Sounds like a board rework document on your support site is the right
> > place for this. 
> 
> Except that no one would know to look there.

Why do you expect people to look at the device tree source file instead?
It seems even more remote to me.

> I don't even know who to contact to get that kind of information on
> that site.

That's a pretty lame excuse. :)

> > We normally don't document board reworks required in
> > the linux sources, do we?
> 
> I do, if I can find a discrete place for it.  The patch for my QE UART 
> driver has a similar comment in the DTS for the 8323E MDS.

Are freescale customers really used to going to the linux device tree
sources to find out how to modify their boards to achieve certain
functionality with their eval boards?! I guess you guys are taking the
"device trees are used to describe the hardware" statement to it's
fullest extent.


-Olof
