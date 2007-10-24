Return-Path: <drow@false.org>
Received: from nan.false.org (NaN.false.org [208.75.86.248])
	by ozlabs.org (Postfix) with ESMTP id 5EFAFDDF14
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 Oct 2007 09:03:54 +1000 (EST)
Date: Wed, 24 Oct 2007 18:41:30 -0400
From: Daniel Jacobowitz <drow@false.org>
To: Matt Mackall <mpm@selenic.com>
Subject: Re: Apparent kernel bug with GDB on ppc405
Message-ID: <20071024224130.GA30819@caradoc.them.org>
References: <20071024194640.GB19691@waste.org>
	<fa686aa40710241328x77435cc1lf09cac730b0ce5ac@mail.gmail.com>
	<20071024204215.GC19691@waste.org>
	<20071024215421.GF19691@waste.org>
	<fa686aa40710241527j1a316760lf36d512eb625810f@mail.gmail.com>
	<20071024223250.GI19691@waste.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071024223250.GI19691@waste.org>
Cc: gdb@sourceware.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Oct 24, 2007 at 05:32:50PM -0500, Matt Mackall wrote:
> Not completely implausible, but a) why isn't this seen on basically
> every machine with software TLB? b) why does -local- GDB, which is
> presumably doing much less work than gdbserver + network stack, not fail?

You said it yourself.  Local gdb does more work -> blows through more
TLB entries.

I can't answer you about the other half, but I'm pretty sure TLB
invalidation is already supposed to be happening... somewhere.

-- 
Daniel Jacobowitz
CodeSourcery
