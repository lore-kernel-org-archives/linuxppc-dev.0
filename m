Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao01.cox.net (fed1rmmtao01.cox.net [68.230.241.38])
	by ozlabs.org (Postfix) with ESMTP id 18BBE2BC0F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Oct 2004 08:16:29 +1000 (EST)
Date: Thu, 14 Oct 2004 15:16:23 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Message-ID: <20041014221623.GD19791@smtp.west.cox.net>
References: <JPEALJAFNGDDLOPNDIEEIEEPCNAA.joakim.tjernlund@lumentis.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <JPEALJAFNGDDLOPNDIEEIEEPCNAA.joakim.tjernlund@lumentis.se>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Merge 8xx to Linus tree?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Oct 14, 2004 at 04:53:49PM +0200, Joakim Tjernlund wrote:

> Is it not time to merge 8xx from linuxppc-2.5 into Linus tree?
> 
> I know the 8xx is not fully functional yet but this isn't done
> soon I think it won't happen at all. The 8xx arch can be made to 
> depend on BROKEN in Linus tree to make it clear that it isn't
> working properly yet.

I've been the hard-ass about holding back on moving 8xx forward.  Once
2.6.9 finally comes out (assuming and hoping that Linus really intends
to do a release and not -rc5), I'll start moving stuff over and make it
depend on BROKEN hopefully in time for 2.6.10-rc1.

-- 
Tom Rini
http://gate.crashing.org/~trini/
