Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A97B6DDE03
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Dec 2007 08:16:07 +1100 (EST)
Subject: Re: [i2c] [PATCH 0/4] Series to add device tree naming to i2c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910712091257x4ba5e07aue55934fb6898aa2d@mail.gmail.com>
References: <20071203212032.23543.3453.stgit@terra.home>
	<9e4733910712091224mcb43f0ci69f578d221505ba7@mail.gmail.com>
	<1197233208.6563.14.camel@pasglop>
	<9e4733910712091257x4ba5e07aue55934fb6898aa2d@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 10 Dec 2007 08:13:19 +1100
Message-Id: <1197234799.6563.19.camel@pasglop>
Mime-Version: 1.0
Cc: Jean Delvare <khali@linux-fr.org>, linuxppc-dev@ozlabs.org,
	i2c@lm-sensors.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sun, 2007-12-09 at 15:57 -0500, Jon Smirl wrote:
> 
> Are there technical concerns with this series? The white space can be
> fixed in a few minutes.
> 
> Adding a tag to differentiate matching types has implications that are
> broader than just i2c. Shouldn't we do this first with the existing
> scheme and then change the tagging process with later patches?

No, we should decide on what to do with the tagging process (or not do)
first, don't you think ? (If we need a tagging process, Scott had a
concern but it might be moot, let's discuss that first).

Ben.
