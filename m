Return-Path: <w@1wt.eu>
Received: from 1wt.eu (1wt.eu [62.212.114.60])
 by ozlabs.org (Postfix) with ESMTP id E9FABB702B
 for <linuxppc-dev@ozlabs.org>; Mon,  9 Apr 2012 23:26:51 +1000 (EST)
Date: Mon, 9 Apr 2012 15:08:30 +0200
From: Willy Tarreau <w@1wt.eu>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: [PATCH 00/14] Backport 8xx TLB to 2.4
Message-ID: <20120409130830.GH15929@1wt.eu>
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

Hi Joakim,

On Wed, Feb 08, 2012 at 12:39:50PM +0100, Joakim Tjernlund wrote:
> I figure, after 2.4.37.12, a public git tree on kernel org which still
> receives fixes would be enough.

FYI, I've merged your patches and pushed them along with a few pending
other ones here :

   http://git.kernel.org/?p=linux/kernel/git/wtarreau/linux-2.4.git;a=summary

There will only be git updates from now on. Probably that once in a while I'll
tag the tree to make things easier to check.

Thanks for taking care of sending fixes for old kernels !

Cheers,
Willy
