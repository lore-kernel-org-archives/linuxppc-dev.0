Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao09.cox.net (fed1rmmtao09.cox.net [68.230.241.30])
	by ozlabs.org (Postfix) with ESMTP id AF2122BDA0
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Dec 2004 07:15:12 +1100 (EST)
Date: Mon, 6 Dec 2004 13:15:00 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Kumar Gala <kumar.gala@freescale.com>
Message-ID: <20041206131500.A9960@home.com>
References: <45ABD2373C33C4459D42B40EC4F346F204912B38@FTWMLVEM03.e2k.ad.ge.com>
	<35B36824-47B6-11D9-8BFE-000393DBC2E8@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <35B36824-47B6-11D9-8BFE-000393DBC2E8@freescale.com>;
	from kumar.gala@freescale.com on Mon, Dec 06, 2004 at 12:39:49PM
	-0600
Cc: "Barbier, Renaud \(GE Infrastructure\)" <Renaud.Barbier@ge.com>,
	linuxppc-embedded@ozlabs.org
Subject: Re: 440GX MMU
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Dec 06, 2004 at 12:39:49PM -0600, Kumar Gala wrote:
> The TS provides an additional bit of address space on Book-E processors 
> (440, e500, etc).  An exception automatically clears the MSR[IS, DS] 
> fields which are used to compare against the TLB's TS field.
> 
> It was the case at one point in time (may still be) that on 440, the 
> interrupt context was TS = 0, everything else was TS = 1.  Matt was 
> going to (or may have) changed it so everything is TS = 0 so we could 
> save a few TLB entries.

It's changed in 2.6 (all AS=0), in 2.4 I never got around to finishing
the update to the MMU handling. Since then, 2.6 has gone way beyond
2.4 in features/fixes so I don't intend to do anything more with
2.4. Patches are welcome for linuxppc-2.4, though.

-Matt
