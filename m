Return-Path: <kyle@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id F14F9B70B5
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Jun 2009 02:45:26 +1000 (EST)
Date: Tue, 23 Jun 2009 12:45:05 -0400
From: Kyle McMartin <kyle@mcmartin.ca>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v2] fbdev: work around old compiler bug
Message-ID: <20090623164505.GA3101@bombadil.infradead.org>
References: <20090622180420.2e0424e4.sfr@canb.auug.org.au>
	<20090622183415.46fa786b.sfr@canb.auug.org.au>
	<20090623154428.e2f4ddc9.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090623154428.e2f4ddc9.sfr@canb.auug.org.au>
Sender: Kyle McMartin <kyle@infradead.org>
Cc: James Simmons <jsimmons@infradead.org>, Sam Ravnborg <sam@ravnborg.org>,
	ppc-dev <linuxppc-dev@lists.ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Krzysztof Helt <krzysztof.h1@poczta.fm>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 23, 2009 at 03:44:28PM +1000, Stephen Rothwell wrote:
> When building with a 4.1.x compiler on powerpc64 (at least) we get
> this error:
> 
> drivers/video/logo/logo_linux_mono.c:81: error: logo_linux_mono causes a section type conflict
> 
> This was introduced by commit ae52bb2384f721562f15f719de1acb8e934733cb
> ("fbdev: move logo externs to header file").  This is a partial revert
> of that commit sufficient to not hit the compiler bug.
> 

We're seeing similar issues with 4.3 on parisc (the case I saw today was
in fs/nfs/nfsroot.c...) Any ideas on the actual culprit or is it just
gcc being unfriendly?

regards, Kyle
