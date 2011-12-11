Return-Path: <w@1wt.eu>
Received: from 1wt.eu (1wt.eu [62.212.114.60])
 by ozlabs.org (Postfix) with ESMTP id BB4A0B7010
 for <linuxppc-dev@ozlabs.org>; Mon, 12 Dec 2011 04:44:40 +1100 (EST)
Date: Sun, 11 Dec 2011 18:33:46 +0100
From: Willy Tarreau <w@1wt.eu>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: [PATCH 00/14] Backport 8xx TLB to 2.4
Message-ID: <20111211173346.GC9019@1wt.eu>
References: <1318246220-4839-1-git-send-email-Joakim.Tjernlund@transmode.se>
 <OF6B6562C0.926C4B3C-ONC1257963.005F34B1-C1257963.005F34B2@transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OF6B6562C0.926C4B3C-ONC1257963.005F34B1-C1257963.005F34B2@transmode.se>
Cc: Scott Wood <scottwood@freescale.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, Dan Malek <ppc6dev@digitaldans.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Joakim,

On Sun, Dec 11, 2011 at 06:19:54PM +0100, Joakim Tjernlund wrote:
> > To: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
> > From: Willy Tarreau <w@1wt.eu>
> > 
> > Hi Joakim,  On Mon, Oct 10, 2011 at 01:30:06PM +0200, Joakim Tjernlund wrote: > This is a
> > backport from 2.6 which I did to overcome 8xx CPU > bugs. 8xx does not update the DAR register
> > when taking a TLB > error caused by dcbX and icbi insns which makes it very > tricky to use these
> > insns. Also the dcbst wrongly sets the > the store bit when faulting into DTLB error. > A few
> > more bugs very found during development. >  > I know 2.4 is in strict maintenance mode and 8xx is
> > obsolete > but as it is still in use I wanted 8xx to age with grace.  Thank you. I must admit I
> > was hoping those patches would come in for a last release before the end of the year :-)  Unless
> > there is any objection from anyone, I'll merge them when kernel.org is back online.  Cheers,
> > Willy
> 
> Did this go anywhere?

Not yet, I just need to find some time to release another 2.4 with these
patches.

Best regards,
Willy
