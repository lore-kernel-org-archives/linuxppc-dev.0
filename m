Return-Path: <machek@atrey.karlin.mff.cuni.cz>
Received: from atrey.karlin.mff.cuni.cz (atrey.karlin.mff.cuni.cz
	[195.113.26.193]) by ozlabs.org (Postfix) with ESMTP id 9A57BB7C59
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Feb 2010 18:34:08 +1100 (EST)
Date: Mon, 15 Feb 2010 08:34:05 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: register long sp asm("r1") incorrect
Message-ID: <20100215073405.GB20456@atrey.karlin.mff.cuni.cz>
References: <20100209152444.GA30176@atrey.karlin.mff.cuni.cz>
	<1265866273.16346.34.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1265866273.16346.34.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Tue, 2010-02-09 at 16:24 +0100, Pavel Machek wrote:
> > ...according to gcc docs, sp should be global, or placement in
> > register is not guaranteed (except at asm boundaries, but there are
> > none).
> 
> Sorry I'm not sure I grok what you mean.

Well, according to gcc doscs and my experience, local "register int
__asm()" variables only work by accident (or not at all).
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
