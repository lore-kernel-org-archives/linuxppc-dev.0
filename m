Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D0B90B7D39
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Jan 2010 21:49:52 +1100 (EST)
In-Reply-To: <20100129154924.d1bf8bc3.akpm@linux-foundation.org>
References: <20100112022150.GE12666@kryten>	<20100112140136.c8ccc357.sfr@canb.auug.org.au>
	<OFF0BABDB9.D573B5F9-ONC12576A9.0041BA69-C12576A9.0041D76A@transmode.se>	<FB3DFBD5-9976-4D03-828A-EB4E6E08DAA4@kernel.crashing.org>
	<1263412963.724.223.camel@pasglop>	<OF20873087.ECC43BEB-ONC12576AB.0029EA9A-C12576AB.002AC5CA@transmode.se>
	<1263459431.724.352.camel@pasglop>	<OF0311C7C7.F02F52A9-ONC12576B6.002D4A11-C12576B6.002DC689@transmode.se>
	<20100127170536.23634cdf.akpm@linux-foundation.org>	<OF871F5B59.C2574563-ONC12576B9.00300E39-C12576B9.0030C51C@transmode.se>
	<20100129154924.d1bf8bc3.akpm@linux-foundation.org>
Subject: Re: [PATCH]: powerpc: Fix build breakage due to incorrect location of
	autoconf.h
To: Andrew Morton <akpm@linux-foundation.org>
Message-ID: <OF6663C9F9.89378713-ONC12576BB.003B188A-C12576BB.003B4798@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Sat, 30 Jan 2010 11:47:29 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Roel Kluin <roel.kluin@gmail.com>,
	"linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Richard Purdie <rpurdie@rpsys.net>, Anton Blanchard <anton@samba.org>,
	David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Andrew Morton <akpm@linux-foundation.org> wrote on 2010/01/30 00:49:24:
>
> On Thu, 28 Jan 2010 09:52:41 +0100
> Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
>
> > Commit 6846ee5ca68d81e6baccf0d56221d7a00c1be18b made the
> > new optimized inflate only available on arch's that
> > define CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS. This
> > will again enable the optimization for all arch's by
> > by defining our own endian independent version
> > of unaligned access. As an added bonus, arch's that
> > define CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS do a
> > plain load instead.
>
> Given that we're at -rc5, that changelog says to me "this is a 2.6.34
> patch".
>
> If that is wrong, please tell me why.

2.6.34 is fine, thanks.

 Jocke
