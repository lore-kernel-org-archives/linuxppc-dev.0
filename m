Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1D100DDF8F
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 09:00:20 +1000 (EST)
Subject: Re: Deputy maintainer for powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20080707152548.5075845f@zod.rchland.ibm.com>
References: <18541.48403.490671.815858@cargo.ozlabs.ibm.com>
	<155B1079-39C4-4D15-B886-F904C424BC8C@kernel.crashing.org>
	<20080707152548.5075845f@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Tue, 08 Jul 2008 08:58:53 +1000
Message-Id: <1215471533.8970.160.camel@pasglop>
Mime-Version: 1.0
Cc: lkml List <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-07-07 at 15:25 -0400, Josh Boyer wrote:
> > Ben, Do you have a tree that you'll be using to collect things in?
> 
> I hope it's the same tree for this merge window.

It's in a different place but it's essentially the same tree (ie, I
pulled in paulus branches and my current heads are identical, at least
until I start adding things to it).

> In the future, I hope the semantics of the various branches of the
> new tree either stays the same, or comes with a detailed description
> of what branch means what (assuming there is a new tree at some
> point).

Branches are the same, master,merge and next (the only subtle difference
is that my next branch is called just "next" and not "powerpc-next").

Ben.
