Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 70887B7CBB
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2010 12:05:57 +1100 (EST)
Date: Wed, 27 Jan 2010 17:05:36 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: [PATCH]: powerpc: Fix build breakage due to incorrect location
	of autoconf.h
Message-Id: <20100127170536.23634cdf.akpm@linux-foundation.org>
In-Reply-To: <OF0311C7C7.F02F52A9-ONC12576B6.002D4A11-C12576B6.002DC689@transmode.se>
References: <20100112022150.GE12666@kryten>
	<20100112140136.c8ccc357.sfr@canb.auug.org.au>
	<OFF0BABDB9.D573B5F9-ONC12576A9.0041BA69-C12576A9.0041D76A@transmode.se>
	<FB3DFBD5-9976-4D03-828A-EB4E6E08DAA4@kernel.crashing.org>
	<1263412963.724.223.camel@pasglop>
	<OF20873087.ECC43BEB-ONC12576AB.0029EA9A-C12576AB.002AC5CA@transmode.se>
	<1263459431.724.352.camel@pasglop>
	<OF0311C7C7.F02F52A9-ONC12576B6.002D4A11-C12576B6.002DC689@transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Mon, 25 Jan 2010 09:19:59 +0100
Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:

> Commit 6846ee5ca68d81e6baccf0d56221d7a00c1be18b made the
> new optimized inflate only available on arch's that
> define CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS. This
> fixes it by defining our own endian independent versions
> of unaligned access.

(I hope I picked up the right version of
whatever-it-was-i-was-supposed-to-pick-up - I wasn't paying attention).

The changelog sucks.  You say the patch fixes "it", but what is "it"? 
Is "it" a build error?  If so, what?  Or is "it" a
make-optimized-inflate-available-on-ppc patch, in which case it's a
"feature"?

Confuzzzzzed.
