Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao09.cox.net (fed1rmmtao09.cox.net [68.230.241.30])
	by ozlabs.org (Postfix) with ESMTP id BF59F2BDEB
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  5 Nov 2004 04:25:53 +1100 (EST)
Date: Thu, 4 Nov 2004 10:25:51 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Rick McBain <rick.mcbain@logicsense.com>
Message-ID: <20041104102551.A12135@home.com>
References: <002b01c4c1fb$49adde60$6802a8c0@RicksPresario900>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <002b01c4c1fb$49adde60$6802a8c0@RicksPresario900>;
	from rick.mcbain@logicsense.com on Wed, Nov 03, 2004 at
	03:17:27PM -0800
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Linux port for the AMCC (was IBM) 440EP
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Nov 03, 2004 at 03:17:27PM -0800, Rick McBain wrote:
> Does anybody have a working distribution for the 440EP? We were planning
> to use a Timesys port, but we've now been told it doesn't exist (after
> months of promises it did.).  Our other option is to pay US$25K to
> MontaVista, but that seems a tad pricey, and our previous experience
> with them is that they delivered us an ARM port which fundamentally
> didn't work.

Since IBM->AMCC did the raw kernel port and toolchain for 440EP, why
don't you ask them for it?  Then you can roll your own distribution
for far cheaper than $25k.  What do you need working?  There are
a lot of new features on 440EP.
 
-Matt
