Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao04.cox.net (fed1rmmtao04.cox.net [68.230.241.35])
	by ozlabs.org (Postfix) with ESMTP id 85A552BDA2
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Sep 2004 02:49:01 +1000 (EST)
Date: Fri, 24 Sep 2004 09:48:58 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Stephen Rothwell <sfr@ozlabs.org>
Message-ID: <20040924094858.A4823@home.com>
References: <20040923164655.0472a8b9.sfr@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040923164655.0472a8b9.sfr@ozlabs.org>;
	from sfr@ozlabs.org on Thu, Sep 23, 2004 at 04:46:55PM +1000
Cc: linuxppc-dev@ozlabs.org
Subject: Re: New mailing list specifically for embedded PowerPC development
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 23, 2004 at 04:46:55PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After some representations, I have created linuxppc-embedded@ozlabs.org
> for the discussion of all things to do with the development of Linux on
> embedded PowerPC platforms.
> 
> General Linux on PowerPC development discussions should, of course, remain
> on this list.

I need further guidelines on utilization of these lists.  If embedded
discussions are on linuxppc-embedded and general development discussions
are on linuxppc-dev, then where do pmac-specific discussions belong?
They certainly don't belong on linuxppc-dev since that is a specific
class of machines that not everybody has interest in and generates
a lot of traffic.

Also, where do I post patches?  I typically try to copy lkml and
linuxppc-dev.  Can we establish that all patches go to linuxppc-dev
regardless of general/embedded/pmac? If not, it seems we'll have
to divide patches up into the generic portion that affects everybody
for linuxppc-dev and then the embedded/pmac portion to go elsewhere.
That would be real waste and make it difficult to follow a patch
set if it were split among lists with differing subscriber bases.

Of course, if we send patches to linuxppc-dev for embedded/pmac specific
items, then that guarantees the generation of discussion outside the
stated scope of the list when people have objection/concerns about a
patch.

I personally feel that the split is unnecessary, but obviously others
had strong feelings so I'm not going to needlessly object any longer.
The most important thing at this point is to provide a bit more detail
on the lists...and probably add a linuxppc-pmac list. :)

-Matt
