Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtai13.cox.net (fed1rmmtai13.cox.net [68.230.241.46])
	by ozlabs.org (Postfix) with ESMTP id D9F8867BCE
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Jul 2005 04:31:44 +1000 (EST)
Date: Thu, 30 Jun 2005 10:41:44 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: john stultz <johnstul@us.ibm.com>
Message-ID: <20050630174144.GG13179@smtp.west.cox.net>
References: <1120082751.24889.120.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1120082751.24889.120.camel@cog.beaverton.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org
Subject: Re: [RFC][PATCH] ppc misusing NTP's time_offset value
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jun 29, 2005 at 03:05:51PM -0700, john stultz wrote:
> Hey everyone,
> 
> 	As part of my timeofday rework, I've been looking at the NTP code and I
> noticed that the PPC architecture is apparently misusing the NTP's
> time_offset (it is a terrible name!) value as some form of timezone
> offset. This could cause problems when time_offset changed by the NTP
> code.
> 	
> 	This patch changes the PPC code so it uses a more clear local variable:
> timezone_offset.
> 
> Could a PPC maintainer verify this is correct?

As mentioned by Mikael, it's odd that this problem came up, since i
guess the wrong patch made it in.  Andrew, please grab this if you
haven't already.  Thanks.

Acked-by: Tom Rini <trini@kernel.crashing.org>

-- 
Tom Rini
http://gate.crashing.org/~trini/
