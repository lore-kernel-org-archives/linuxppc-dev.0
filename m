Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2CC0BDDE02
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2007 18:40:00 +1000 (EST)
Subject: Re: cbe_cpufreq crashes my machine
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20070426065644.GA24799@lixom.net>
References: <20070425204633.GC19781@lixom.net>
	<200704260147.35878.arnd@arndb.de> <20070426065644.GA24799@lixom.net>
Content-Type: text/plain
Date: Thu, 26 Apr 2007 18:39:45 +1000
Message-Id: <1177576785.14873.249.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
	Christian Krafft <krafft@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-04-26 at 01:56 -0500, Olof Johansson wrote:
> On Thu, Apr 26, 2007 at 01:47:35AM +0200, Arnd Bergmann wrote:
> > I can't see any check in here that finds out if you are actually running on
> > the right hardware. 
> 
> Seems like this came along with our use of cbe_cpufreq.c as a basis. You
> don't do it either! :-)
> 
> Enabling CONFIG_CBE_CPUFREQ makes my machine die a horrible death,
> see below. I'd post a patch if I knew what machine compatible fields to
> compare with, but I have no clue what's considered approprate to check
> for on cell.

Or machine_is(cell)

Ben.
