Return-Path: <flar@pants.nu>
Received: from cynthia.pants.nu (adsl-216-102-214-42.dsl.snfc21.pacbell.net
	[216.102.214.42]) by ozlabs.org (Postfix) with ESMTP id 9810867A86
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Feb 2005 05:29:06 +1100 (EST)
Date: Fri, 18 Feb 2005 09:58:22 -0800
From: Brad Boyer <flar@allandria.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Message-ID: <20050218175822.GA30616@pants.nu>
References: <20050127163606.GN14866@Redstar.dorchain.net>
	<20050118094216.GB25470@Redstar.dorchain.net>
	<20050126113554.GD19633@schottelius.org>
	<1106746946.6250.56.camel@gaston>
	<20050208075421.GB21154@schottelius.org>
	<8f293b6dbedd2ae1a825608a48a0604b@kernel.crashing.org>
	<20050218111304.GH5801@schottelius.org>
	<f585c9c6e4bdfbba6dcaafc96b7c0607@kernel.crashing.org>
	<20050218122009.GK5801@schottelius.org>
	<629f63c4608b762de8bf6f962b6180ef@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <629f63c4608b762de8bf6f962b6180ef@kernel.crashing.org>
Cc: Nico Schottelius <nico-linux-ppc@schottelius.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] Heartbeat LED for iBook
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 18, 2005 at 02:00:32PM +0100, Segher Boessenkool wrote:
> There is no manual.  You can look at some Darwin source code,
> I guess, or there is some code in Linux to do this as well, IIRC.

There is some minimal documentation available. Some Apple docs:

ADB-The Untold Story: Space Aliens Ate My Mouse
http://developer.apple.com/technotes/hw/hw_01.html

Inside Macintosh: Devices / Chapter 5 - ADB Manager
http://developer.apple.com/documentation/mac/Devices/Devices-203.html

These will tell you the basic design of ADB as well as the packet
formats and information about keyboards and mice.

Note that these document ADB in a generic sense, so nothing PMU
specific is in them. Apple has been very reluctant to document
the PMU and it's functions.

	Brad Boyer
	flar@allandria.com
