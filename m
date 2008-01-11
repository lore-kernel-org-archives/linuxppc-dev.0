Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2912EDE05E
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jan 2008 10:25:15 +1100 (EST)
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: StorCenter Help? 
In-Reply-To: Your message of "Fri, 11 Jan 2008 16:20:12 MST."
	<fa686aa40801111520m3b9c3ea6rc7ee38519dcc9a4b@mail.gmail.com>
References: <E1JDT1Q-0007Bj-1Q@jdl.com>
	<fa686aa40801111520m3b9c3ea6rc7ee38519dcc9a4b@mail.gmail.com>
Date: Fri, 11 Jan 2008 17:25:11 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1JDTFP-0007OE-MM@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day "Grant Likely" mumbled:
> 
> Since you're getting absolutely no output after uncompression it
> probably means that you're failing in the boot wrapper...

Or not getting to the boot wrapper...

> which means mmu is off, and the serial port is already set up by u-boot.
>
> You should be able to add direct writes to the uart fifo register from
> within the bootwrapper code to see how far you get in the progress.

Tried that.  Didn't work at all.

I think I have some variant of BAT setup failure or so.

jdl
