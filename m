Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by ozlabs.org (Postfix) with ESMTP id C1B91DDE11
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Dec 2008 05:53:08 +1100 (EST)
Date: Thu, 11 Dec 2008 18:52:56 +0000
From: Mark Brown <broonie@sirena.org.uk>
To: Timur Tabi <timur@freescale.com>
Message-ID: <20081211185255.GA16784@sirena.org.uk>
References: <49411308.1050008@fang.fa.gau.hu>
	<ed82fe3e0812110712r4baeea60ied52937aa434f48e@mail.gmail.com>
	<20081211153158.GF30808@sirena.org.uk>
	<49413487.9030805@freescale.com>
	<20081211154411.GG30808@sirena.org.uk>
	<49413596.6030803@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49413596.6030803@freescale.com>
Subject: Re: MPC8610HPCD sound as module
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Dec 11, 2008 at 09:45:26AM -0600, Timur Tabi wrote:

> And since I fixed the code in the V2 drivers, I have no interest in fixing it in
> the V1 drivers, which are officially in maintenance mode -- only critical bug
> fixes, no new features.

Well, from that point of view now would be a good time for you to start
backporting your newer code.  The concept of having the core wait for
subdevices to probe is now there which was the major win from the point
of view of integration with the device tree.  What's there now also has
the changes you wanted without the use of templates in the ASoC core so
you can do a single memory allocation for devices rather than having to
fill out templates and have the core do allocations for you.
