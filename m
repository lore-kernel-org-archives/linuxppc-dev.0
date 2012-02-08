Return-Path: <w@1wt.eu>
Received: from 1wt.eu (1wt.eu [62.212.114.60])
 by ozlabs.org (Postfix) with ESMTP id 9BCFFB6EF7
 for <linuxppc-dev@ozlabs.org>; Wed,  8 Feb 2012 23:26:45 +1100 (EST)
Date: Wed, 8 Feb 2012 13:26:38 +0100
From: Willy Tarreau <w@1wt.eu>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: [PATCH 00/14] Backport 8xx TLB to 2.4
Message-ID: <20120208122638.GE1379@1wt.eu>
References: <1318246220-4839-1-git-send-email-Joakim.Tjernlund@transmode.se>
 <OF6B6562C0.926C4B3C-ONC1257963.005F34B1-C1257963.005F34B2@transmode.se>
 <20111211173346.GC9019@1wt.eu>
 <OF173F1835.8171C985-ONC125799E.002FE8C7-C125799E.0030008A@transmode.se>
 <20120208094426.GC1379@1wt.eu>
 <OFE7D02EF5.C8AA7552-ONC125799E.0037BB62-C125799E.0040126D@transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OFE7D02EF5.C8AA7552-ONC125799E.0037BB62-C125799E.0040126D@transmode.se>
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

On Wed, Feb 08, 2012 at 12:39:50PM +0100, Joakim Tjernlund wrote:
> > BTW, since you're asking, you seem to still be using 2.4. Do you think it's
> > worth pursuing maintenance over 2.4.37.12 and if so for how long ? I'm asking
> > because until the break-in, I felt like almost nobody was using it anymore,
> > but since the break-in, I received a number of mails asking where to download
> > it. So now I assume that there are still users, but they're too much silent.
> 
> yes, they are silent I guess. I figure, after 2.4.37.12, a public git tree
> on kernel org which still receives fixes would be enough.

That's probably a good idea indeed. It avoids the need for a release for a
single patch and still allows people to pick patches when they intend to
build something.

Regards,
Willy
