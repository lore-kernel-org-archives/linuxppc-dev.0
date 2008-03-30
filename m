Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 98A12DDE19
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Mar 2008 04:09:10 +1000 (EST)
In-Reply-To: <20080327171045.GA3266@localhost.localdomain>
References: <20080326202453.GC1772@localhost.localdomain>
	<20080327171045.GA3266@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <61b92a2a0440c1f93d2471365aae6e72@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 3/5] leds: implement OpenFirmare GPIO LEDs driver
Date: Sun, 30 Mar 2008 20:08:43 +0200
To: avorontsov@ru.mvista.com
Cc: linuxppc-dev@ozlabs.org, Richard Purdie <rpurdie@rpsys.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Here is updated patch with new linux,brightness OF property (needed for
> MPC8349E-mITX board -- pwr led should be "on" by default).
>
> p.s. I tend to do documentation as a separate patch: I don't want this
> patch to depend on the booting-without-of.txt -- it may produce
> conflicts easily.

We need to see that documentation first though: it is not documenting
this code, it is defining the device binding!  Without it, we can
only guess whether this code is correct or not.  Also, it is important
to decide on a binding before accepting this code.

If patches to booting-without-of.txt conflict often, we should split
it into a directory of files.


Segher
