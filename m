Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmpop110.cox.net (fed1rmpop110.cox.net [68.230.241.14])
	by ozlabs.org (Postfix) with ESMTP id 938C2DDF1B
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Jul 2008 01:29:34 +1000 (EST)
Date: Fri, 4 Jul 2008 08:17:35 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Update maintainers for powerpc
Message-ID: <20080704151735.GA10351@smtp.west.cox.net>
References: <18542.970.878558.275775@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18542.970.878558.275775@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	torvalds@linux-foundation.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jul 04, 2008 at 09:04:42PM +1000, Paul Mackerras wrote:

> This updates the MAINTAINERS entries for powerpc.  It adds Ben H to
> the overall Linux for PowerPC entry and makes it clear this covers
> both 32-bit and 64-bit machines.  It removes the separate entry we had
> for Linux on 64-bit PowerPC where Anton and I were listed as
> maintainers - Anton hasn't been involved in the day-to-day maintenance
> of the code for several years.  Finally, it removes the entry for the
> Linux for PowerPC boot code where Tom Rini was listed as the
> maintainer.  That code got completely rewritten when we merged
> 32-bit and 64-bit, and I and the various platform maintainers have
> been maintaining that code since.
> 
> Signed-off-by: Paul Mackerras <paulus@samba.org>

Acked-by: Tom Rini <trini@kernel.crashing.org>

-- 
Tom Rini
