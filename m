Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: libfdt: More tests of NOP handling behaviour 
In-Reply-To: Your message of "Mon, 18 Feb 2008 16:09:25 +1100."
	<20080218050925.GH29975@localhost.localdomain>
References: <20080218050925.GH29975@localhost.localdomain> 
Date: Mon, 18 Feb 2008 08:24:56 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1JR6vQ-0000h9-2f@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day David Gibson mumbled:
> In light of the recently discovered bug with NOP handling, this adds
> some more testcases for NOP handling.  Specifically, it adds a helper
> program which will add a NOP tag after every existing tag in a dtb,
> and runs the standard battery of tests over trees mangled in this way.
> 
> For now, this does not add a NOP at the very beginning of the
> structure block.  This causes problems for libfdt at present, because
> we assume in many places that the root node's BEGIN_NODE tag is at
> offset 0.  I'm still contemplating what to do about this (with one
> option being simply to declare such dtbs invalid).
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

BTW, declaring DTBs with BEGIN_NODES not at offset 0
as invalid seems like a fine choice to me.

jdl
