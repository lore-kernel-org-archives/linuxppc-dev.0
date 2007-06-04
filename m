Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 34828DDE0E
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Jun 2007 10:10:38 +1000 (EST)
Date: Sun, 3 Jun 2007 19:16:39 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/8] Add uli1575 pci-bridge sector to MPC8641HPCN dts file.
Message-ID: <20070604001639.GA25972@lixom.net>
References: <1180720112.14219.62.camel@ld0161-tx32>
	<dfc15991e31bfc09389461dc443acd7c@kernel.crashing.org>
	<E1HuGfE-0007zw-EH@jdl.com>
	<1180743742.19517.485.camel@localhost.localdomain>
	<e2020ffad171013c07f8809e1e1aef97@kernel.crashing.org>
	<E1HuW61-00049R-FI@jdl.com>
	<27807251665003e059b2c39d2b700415@kernel.crashing.org>
	<1180826202.14025.12.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1180826202.14025.12.camel@localhost.localdomain>
From: olof@lixom.net (Olof Johansson)
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Jun 03, 2007 at 09:16:42AM +1000, Benjamin Herrenschmidt wrote:
> On Sat, 2007-06-02 at 22:00 +0200, Segher Boessenkool wrote:
> > The official (and unofficial) Open Firmware docs are quite
> > good.  Perhaps we need a big huge fat sign in the DTS docs
> > pointing to them.
> 
> They aren't -that- good when you come out of the blue and don't know
> where to start. I think a tutorial based on building a tree for an
> example board step by step would be best.

There seems to be two things that causes problems:

1) People basing their new tree on an old example that's broken, and
getting crap for that because it's not correct

2) Trying to add new devices that aren't in any trees already, and
the near infinite discussions that then start.

(1) Could clearly be solved to a fair extent by having a "blessed
golden tree" that people can clone their own board files from, instead
of grabbing a random one and hoping that it's not too broken.

(2) I don't have a good solution for. Better documentation pointers would
definitely be a help, but it's not the whole solution. I'd expect it to
get better and better over time as there'll be less and less unmapped
terrain, and better and better examples to use.


-Olof
