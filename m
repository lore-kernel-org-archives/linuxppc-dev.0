Return-Path: <dan@embeddedalley.com>
Received: from smtp101.biz.mail.re2.yahoo.com (smtp101.biz.mail.re2.yahoo.com
	[68.142.229.215]) by ozlabs.org (Postfix) with SMTP id 1CCBB67B88
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jul 2006 01:25:39 +1000 (EST)
In-Reply-To: <41AD230F-91E8-442A-B9F9-9892D14BEF12@kernel.crashing.org>
References: <4879B0C6C249214CBE7AB04453F84E4D0509EB@zch01exm20.fsl.freescale.net>
	<41AD230F-91E8-442A-B9F9-9892D14BEF12@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <8159D4D8-0EFC-4229-9C5E-E00C71EC4602@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: [PATCH] Add USB to MPC8349 PB platform support
Date: Tue, 18 Jul 2006 11:19:13 -0400
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 18, 2006, at 9:52 AM, Kumar Gala wrote:

> .....  I'm concerned about where to draw the line because of all  
> the ways a user can configure the MDS board.

IMHO, you choose one configuration that works and
make that the board port.  If someone wants to change
it later, it would be a good exercise for them to learn
how to do such things  From years of working with these
things I'll suggest that it's not worthwhile to make this
so complicated that you think it's going to be everything
for anyone.  It's not the way people use these boards.

The best thing we should do is clearly document
one board configuration and have the Linux configuration
that matches.  It's horribly misleading to present a board
that is infinitely configurable and implying you can
find a Linux configuration to match.  They are guaranteed
to find something that doesn't work on their first
attempt, and then all of the "broken this" and "broken
that" finger pointing starts :-)

Thanks.

	-- Dan
