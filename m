Return-Path: <dale@farnsworth.org>
Received: from farnsworth.org (unknown [65.200.49.142])
	by ozlabs.org (Postfix) with SMTP id 2BD4E68A00
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Feb 2006 06:37:35 +1100 (EST)
Date: 2 Feb 2006 19:37:34 -0000
Message-ID: <20060202193734.22145.qmail@farnsworth.org>
From: "Dale Farnsworth" <dale@farnsworth.org>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] Add fec support for mpc52xx
In-Reply-To: <43E24DA6.9@freescale.com>
Cc: Sylvain Munaut <tnt@246tNt.com>, John Rigby <jrigby@freescale.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In article <43E24DA6.9@freescale.com> John Rigby wrote:
> Adds fec support, requires bestcom patch.  Applies to Sylvains git tree.

Hmm, I thought that fec support was already in Sylvain's git tree.

I'm sure Sylvain intended it to be there.

>From http://ozlabs.org/pipermail/linuxppc-embedded/2005-June/018887.html:
> Date: Sun, 19 Jun 2005 00:15:32 +0200
> From: Sylvain Munaut <tnt@246tNt.com>
> 
> Following the obvious demand for it :
> 
> rsync://gitbits.246tNt.com/gitbits/linux-2.6-mpc52xx.git
> http://gitbits.246tNt.com/gitweb.cgi?p=linux-2.6-mpc52xx.git;a=summary
> 
> Hopefully the server is setup correctly ...
> It's not _heavily_ tested but it seems to works fine in the few test I
> made.
> 
> What in there :
>  - I2C patches that are already sent upstream but not yet in Linus tree
>  - Change of the mpc52xx uart device name and device ids to a range in
>    the low density serial port major. Also it's now named ttyPSC? so
>    you need to update you kernel command line (else you won't see any
>    console). Note that the ids and names choosed are NOT YET OFFICIAL,
>    I just included it in this release because some people were seeing
>    conflict with the other ids. So the name and ids may change ...
>  - Some other patches that will soon be sent upstream, just waiting
>    for you to test see if it has any negative impact.
>  - FEC and BestComm rewrite from Dale, with some improvement. For eg,
>    the FEC task now handle misaligment so the manual alignment code
>    has been removed, ...

I hope Sylvain can resurrect the 2.6 FEC code that he, I and others
worked on.

-Dale
