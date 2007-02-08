Return-Path: <adrian@rhlx01.hs-esslingen.de>
Received: from rhlx01.hs-esslingen.de (rhlx01.hs-esslingen.de [129.143.116.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "rhlx01.hs-esslingen.de",
	Issuer "HE CA - G01" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 0C397DDEA3
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Feb 2007 05:01:23 +1100 (EST)
Date: Thu, 8 Feb 2007 19:01:19 +0100
From: Adrian Reber <adrian@lisas.de>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Cbe-oss-dev] [RFC,
	PATCH] CELL Oprofile SPU profiling updated patch
Message-ID: <20070208180119.GA24743@lisas.de>
References: <1170721711.5204.44.camel@dyn9047021078.beaverton.ibm.com>
	<1170802957.5204.56.camel@dyn9047021078.beaverton.ibm.com>
	<b682962303654f4958a6c2c50d805907@bga.com>
	<200702081821.57358.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200702081821.57358.arnd@arndb.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Milton Miller <miltonm@bga.com>,
	linuxppc-dev@ozlabs.org, oprofile-list@lists.sourceforge.net,
	cbe-oss-dev@ozlabs.org, Carl Love <cel@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 08, 2007 at 06:21:56PM +0100, Arnd Bergmann wrote:
[...]
> Moving the sample rate computation to user space sounds like the right
> idea, but why not have a more drastic version of it:
> 
> Right now, all products that support this feature run at the same clock
> rate (3.2 Ghz), with cpufreq, we can reduce this to 1.6 Ghz. If I understand
> this correctly, the value depends only on the frequency, so we could simply
> hardcode this in the kernel, and print out a warning message if we ever
> encounter a different frequency, right?

Just for the record... CAB is running with 2.8 GHz. At least all the boards
I have seen.

		Adrian
