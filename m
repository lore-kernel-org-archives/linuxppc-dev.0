Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao12.cox.net (fed1rmmtao12.cox.net [68.230.241.27])
	by ozlabs.org (Postfix) with ESMTP id 2ACD12BF17
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 15 Jan 2005 05:05:16 +1100 (EST)
Date: Fri, 14 Jan 2005 11:05:11 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Message-ID: <20050114180511.GC28724@smtp.west.cox.net>
References: <20050114174734.GB28724@smtp.west.cox.net>
	<JPEALJAFNGDDLOPNDIEEAECFDAAA.joakim.tjernlund@lumentis.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <JPEALJAFNGDDLOPNDIEEAECFDAAA.joakim.tjernlund@lumentis.se>
Cc: "Linuxppc-Embedded@Ozlabs. Org" <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] Handle I-TLB Error and Miss separately on 8xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Jan 14, 2005 at 06:56:58PM +0100, Joakim Tjernlund wrote:
> > > Your patch will fix this. 
> > > I havn't seen it go in yet, will you submit the patch to Linus/Marcelo?
> > 
> > I was hoping Marcelo would pick this up since I thought he was on the
> > list.  I'll re-poke him.  For 2.6, the app in question crashes
> > differently, prior to hitting this bug, but I do want to get it pushed
> > out.  I've just been swamped lately.
> 
> Is 2.6 on 8xx stable for you(except for this app)? I was under the impression that
> 2.6 was a bit flaky due to an unidentified MM bug.

No, I don't believe it's very stable (this wa the first chance I've had
in a while to fire up my rpxlite).

-- 
Tom Rini
http://gate.crashing.org/~trini/
