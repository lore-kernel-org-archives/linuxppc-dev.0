Return-Path: <dgibson@ozlabs.org>
Date: Sat, 22 Dec 2007 13:05:31 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH 2/3] sbc8548: Add device tree source for Wind River
	SBC8548 board
Message-ID: <20071222020531.GA7891@localhost.localdomain>
References: <11982194332672-git-send-email-paul.gortmaker@windriver.com>
	<11982194344016-git-send-email-paul.gortmaker@windriver.com>
	<1198219435310-git-send-email-paul.gortmaker@windriver.com>
	<1ED67FCC-132F-4E9A-BDC9-41BF557FF0D6@kernel.crashing.org>
	<20071221172023.GA23220@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071221172023.GA23220@windriver.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Dec 21, 2007 at 12:20:24PM -0500, Paul Gortmaker wrote:
> In message: Re: [PATCH 2/3] sbc8548: Add device tree source for Wind River SBC8548 board
> on 21/12/2007 Kumar Gala wrote:
> 
> >
> > On Dec 21, 2007, at 12:43 AM, Paul Gortmaker wrote:
> >
> >> This adds the device tree source for the Wind River SBC8548 board. 
> 
> [...]
> 
> > mind looking at converting this to a dts-v1 format?
> >
> > - k
> 
> I figured there might be value in having it as a separate commit, seeing
> as there aren't that many other dts-v1 as a reference (yet).  Not sure
> if I've got all the v1 type changes in that you had in mind, but I fed
> it through the latest dtc from git and fed it to the board and it still
> seems happy with it.

There are really only two changes with dts-v1.
	1) All integers become C-style, so, decimal by default with
leading 0, 0x or 0b for octal/hex/binary.  d# h# o# are no longer
supported.
	2) References to pths must be writte as &{/some/node/or/other}
instead of &/some/node/or/other.  References to labels remain fine as
just &label.

The explicit new source version isn't because the format changes are
large, just because there was no way to make them in a
backwards-compatible way.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
